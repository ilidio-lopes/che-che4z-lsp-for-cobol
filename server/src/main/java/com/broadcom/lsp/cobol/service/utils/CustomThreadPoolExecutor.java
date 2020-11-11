/*
 * Copyright (c) 2020 Broadcom.
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
package com.broadcom.lsp.cobol.service.utils;

import java.util.concurrent.ExecutorService;
import java.util.concurrent.ScheduledExecutorService;

/**
 * Interface profides API for custom thread pool using ThreadPoolExecutor and
 * ScheduledThreadPoolExecutor.
 */
public interface CustomThreadPoolExecutor {

  /**
   * Provides configurable ThreadPoolExecutor.
   *
   * @return ThreadPoolExecutor
   */
  ExecutorService getThreadPoolExecutor();

  /**
   * Provides configurable ScheduledThreadPoolExecutor
   *
   * @return ScheduledThreadPoolExecutor
   */
  ScheduledExecutorService getScheduledThreadPoolExecutor();
}
