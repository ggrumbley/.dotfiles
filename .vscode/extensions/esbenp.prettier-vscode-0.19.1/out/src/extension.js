"use strict";
Object.defineProperty(exports, "__esModule", { value: true });
const vscode_1 = require("vscode");
const PrettierEditProvider_1 = require("./PrettierEditProvider");
function checkConfig() {
    const config = vscode_1.workspace.getConfiguration('prettier');
    if (config.useFlowParser) {
        vscode_1.window.showWarningMessage("Option 'useFlowParser' has been deprecated. " +
            'Use \'parser: "flow"\' instead.');
    }
    if (typeof config.trailingComma === 'boolean') {
        vscode_1.window.showWarningMessage("Option 'trailingComma' as a boolean value has been deprecated. " +
            "Use 'none', 'es5' or 'all' instead.");
    }
    return config;
}
function activate(context) {
    const editProvider = new PrettierEditProvider_1.default();
    const config = checkConfig();
    const languageSelector = [
        ...config.javascriptEnable,
        ...config.typescriptEnable,
        ...config.cssEnable,
    ];
    context.subscriptions.push(vscode_1.languages.registerDocumentRangeFormattingEditProvider(languageSelector, editProvider), vscode_1.languages.registerDocumentFormattingEditProvider(languageSelector, editProvider));
}
exports.activate = activate;
// this method is called when your extension is deactivated
function deactivate() { }
exports.deactivate = deactivate;
//# sourceMappingURL=extension.js.map