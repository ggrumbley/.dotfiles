"use strict";

const {CompositeDisposable, Disposable, Emitter} = require("atom");
const {isString}    = require("../utils/general.js");
const {lstat}       = require("../utils/fs.js");
const Storage       = require("../storage.js");
const UI            = require("../ui.js");
const Directory     = require("./directory.js");
const EntityType    = require("./entity-type.js");
const File          = require("./file.js");


class FileSystem {
	
	init(){
		this.paths = new Map();
		this.inodes = new Map();
		this.emitter = new Emitter();
		
		this.disposables = new CompositeDisposable(
			UI.onOpenFile(editor => this.get(editor.getPath()).addEditor(editor)),
			UI.onSaveNewFile(args => this.get(args.file).addEditor(args.editor))
		);
	}
	
	
	reset(){
		this.disposables.dispose();
		this.emitter.dispose();
		this.paths.forEach(path => path.destroy());
		this.inodes.clear();
		this.inodes = null;
		this.paths = null;
		this.emitter = null;
		this.disposables = null;
	}
	
	
	/**
	 * Return a {Resource} for the designated path.
	 *
	 * Paths are not required to point to accessible resources. Entities
	 * which can't be lstat are simply marked unreadable. This behaviour
	 * can be disabled for nonexistent resources by passing `mustExist`.
	 *
	 * @param {String} path - Absolute pathname
	 * @param {Boolean} [mustExist=false] - Return null on ENOENT
	 * @return {Resource}
	 * @emits did-register
	 */
	get(path, mustExist = false){
		const resource = this.paths.get(path);
		
		if(resource)
			return resource;
		
		else if(!path)
			throw new TypeError("Path cannot be empty");
		
		else{
			lstat.lastError = null;
			const stats = lstat(path);
			const inode = stats ? stats.ino : null;
			
			// Return null for nonexistent entities if `mustExist` is truthy
			if(mustExist && lstat.lastError && "ENOENT" === lstat.lastError.code)
				return null;
			
			if(inode){
				// Don't reregister an entity after it's been moved
				if(stats.nlink < 2 && this.inodes.has(inode)){
					const resource = this.inodes.get(inode);
					resource.setPath(path);
					return resource;
				}
				else Storage.setPathInode(path, inode);
			}
			
			const resource = stats && stats.isDirectory()
				? new Directory(path, stats)
				: new File(path, stats);
			
			this.paths.set(path, resource);
			inode && this.inodes.set(inode, resource);
			
			const disposables = new CompositeDisposable(
				resource.onDidDestroy(() => disposables.dispose()),
				resource.onDidMove(paths => this.fixPath(paths.from, paths.to)),
				resource.onDidChangeRealPath(path => this.fixSymlink(resource, path.to)),
				new Disposable(() => {
					this.paths.delete(resource.path);
					if(inode && resource.stats.nlink < 2)
						this.inodes.delete(inode);
				})
			);
			
			this.emitter.emit("did-register", resource);
			return resource;
		}
	}
	
	
	
	fixPath(oldPath, newPath){
		const resource = this.paths.get(oldPath);
		
		if(resource.path !== newPath)
			resource.setPath(newPath);
		
		else{
			this.paths.delete(oldPath);
			this.paths.set(newPath, resource);
		}
	}
	
	
	fixSymlink(link, targetPath){
		const target = this.get(targetPath);
		link.icon.master = target.icon;
	}


	/**
	 * Register a callback to fire for each current and future resource.
	 *
	 * @param {Function} fn - Callback receiving the registered resource
	 * @return {Disposable}
	 */
	observe(fn){
		const output = this.emitter.on("did-register", fn);
		this.paths.forEach(resource => {
			this.emitter.emit("did-register", resource);
		});
		return output;
	}
}



Object.assign(FileSystem.prototype, EntityType);

module.exports = new FileSystem();
