/*
 * Copyright (c) 2024 Broadcom.
 * The term "Broadcom" refers to Broadcom Inc. and/or its subsidiaries.
 *
 * This program and the accompanying materials are made
 * available under the terms of the Eclipse Public License 2.0
 * which is available at https://www.eclipse.org/legal/epl-2.0/
 *
 * SPDX-License-Identifier: EPL-2.0
 *
 * Contributors:
 *    Broadcom, Inc. - initial API and implementation
 *
 */
package org.eclipse.lsp.cobol.usecases.sql;

import com.google.common.collect.ImmutableList;
import com.google.common.collect.ImmutableMap;
import org.eclipse.lsp.cobol.common.error.ErrorSource;
import org.eclipse.lsp.cobol.test.engine.UseCaseEngine;
import org.eclipse.lsp4j.Diagnostic;
import org.eclipse.lsp4j.DiagnosticSeverity;
import org.eclipse.lsp4j.Range;
import org.junit.jupiter.api.Test;

/**
 * Test DB2 identifier length validation for table names and column names.
 */
class TestSqlIdentifierLength {

  private static final String TEXT =
          "       IDENTIFICATION DIVISION.\n"
                  + "       PROGRAM-ID. HELLO-SQL.\n"
                  + "       DATA DIVISION.\n"
                  + "       WORKING-STORAGE SECTION.\n"
                  + "       PROCEDURE DIVISION.\n"
                  + "           EXEC SQL\n"
                  + "             DROP TABLE ABCDEFGHIJKLMNOPQRSTUVWXYZ012345678ggggggggk\n"
                  + "      -    HIJKLMNOPQRSTUVWXYZ01234567890ABCDEFGHIJKLMNOPQRSTUVWXYZ1\n"
                  + "      -    234567890ABCDEFGHIJKLMNOPsfsf{|1}\n"
                  + "           END-EXEC.";

  @Test
  void testTableNameExceeds128Bytes() {
    UseCaseEngine.runTest(
            TEXT,
            ImmutableList.of(),
            ImmutableMap.of(
                    "1",
                    new Diagnostic(
                            new Range(),
                            "table name cannot exceed 128 characters",
                            DiagnosticSeverity.Error,
                            ErrorSource.PREPROCESSING.getText())));
  }
}
