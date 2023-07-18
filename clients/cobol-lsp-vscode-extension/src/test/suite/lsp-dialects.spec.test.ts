/*
 * Copyright (c) 2023 Broadcom.
 * The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
 *
 * This program and the accompanying materials are made
 * available under the terms of the Eclipse Public License 2.0
 * which is available at https://www.eclipse.org/legal/epl-2.0/
 *
 * SPDX-License-Identifier: EPL-2.0
 *
 * Contributors:
 *   Broadcom, Inc. - initial API and implementation
 */

import * as assert from "assert";
import * as helper from "./testHelper";
import * as vscode from "vscode";


suite("COBOL LS DaCo Dialects Integration Test Suite", function () {
  suiteSetup(async function () {
    this.timeout(helper.TEST_TIMEOUT);
    helper.updateConfig("daco.json");
    await helper.activate();
  });

  this.afterEach(async () => await helper.closeAllEditors()).timeout(
    helper.TEST_TIMEOUT,
  );

  test("TC350457: Set DaCo dialects and verify DaCo supported cobol program", async () => {
    await helper.showDocument("cobol-daco/DABPAERR.cbl");
    let editor = helper.get_editor("cobol-daco/DABPAERR.cbl");
    await helper.waitFor(
      () => vscode.languages.getDiagnostics(editor.document.uri).length === 1
    );
    let diagnostics = vscode.languages.getDiagnostics(editor.document.uri);
    assert.strictEqual(diagnostics.length, 1);
  })
    .timeout(helper.TEST_TIMEOUT)
    .slow(1000);  

  test("TC350458: Set DaCo dialects and verify IDMS supported cobol program", async () => {
    await helper.showDocument("cobol-idms/DACRFERR.cbl");
    let editor = helper.get_editor("cobol-idms/DACRFERR.cbl");
    await helper.waitFor(
      () => vscode.languages.getDiagnostics(editor.document.uri).length === 1
    );
    let diagnostics = vscode.languages.getDiagnostics(editor.document.uri);
    assert.strictEqual(diagnostics.length, 1);
  })
    .timeout(helper.TEST_TIMEOUT)
    .slow(1000);    
});

suite("COBOL LS IDSM Dialects Integration Test Suite", function () {
  suiteSetup(async function () {
    this.timeout(helper.TEST_TIMEOUT);
    helper.updateConfig("idms.json");
    await helper.activate();
  });

  this.afterEach(async () => await helper.closeAllEditors()).timeout(
    helper.TEST_TIMEOUT,
  );

  test("TC350459: Set IDMS dialects and verify IDMS supported cobol program", async () => {
    await helper.showDocument("cobol-idms/DACRFERR.cbl");
    let editor = helper.get_editor("cobol-idms/DACRFERR.cbl");
    await helper.waitFor(
      () => vscode.languages.getDiagnostics(editor.document.uri).length === 1
    );
    let diagnostics = vscode.languages.getDiagnostics(editor.document.uri);
    assert.strictEqual(diagnostics.length, 1);
  })
    .timeout(helper.TEST_TIMEOUT)
    .slow(1000);

  test("TC350460: Set IDMS dialects and verify DaCo supported cobol program", async () => {
    await helper.showDocument("cobol-daco/DABPAERR.cbl");
    let editor = helper.get_editor("cobol-daco/DABPAERR.cbl");
    await helper.waitFor(
      () => vscode.languages.getDiagnostics(editor.document.uri).length > 1
    );
    let diagnostics = vscode.languages.getDiagnostics(editor.document.uri);
    assert.notStrictEqual(diagnostics.length, 0);
  })
    .timeout(helper.TEST_TIMEOUT)
    .slow(1000);  
});
