/*
 * File   : $Source: /alkacon/cvs/opencms/src/org/opencms/db/jpa/CmsDbContextFactory.java,v $
 * Date   : $Date: 2010/11/30 09:33:53 $
 * Version: $Revision: 1.1 $
 *
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) 2002 - 2009 Alkacon Software (http://www.alkacon.com)
 *
 * This library is free software; you can redistribute it and/or
 * modify it under the terms of the GNU Lesser General Public
 * License as published by the Free Software Foundation; either
 * version 2.1 of the License, or (at your option) any later version.
 *
 * This library is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the GNU
 * Lesser General Public License for more details.
 *
 * For further information about Alkacon Software, please see the
 * company website: http://www.alkacon.com
 *
 * For further information about OpenCms, please see the
 * project website: http://www.opencms.org
 * 
 * You should have received a copy of the GNU Lesser General Public
 * License along with this library; if not, write to the Free Software
 * Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
 */

package org.opencms.db.jpa;

import org.opencms.db.CmsDbContext;
import org.opencms.db.CmsDriverManager;
import org.opencms.db.I_CmsDbContextFactory;
import org.opencms.file.CmsRequestContext;

/**
 * The jpa implementation of {@link I_CmsDbContextFactory}.<p>
 * 
 * @author Georgi Naplatanov
 * @author Ruediger Kurz
 * 
 * @version $Revision: 1.1 $
 * 
 * @since 8.0.0
 */
public class CmsDbContextFactory implements I_CmsDbContextFactory {

    /**
     * @see org.opencms.db.I_CmsDbContextFactory#getDbContext()
     */
    @Override
    public CmsDbContext getDbContext() {

        return new org.opencms.db.jpa.CmsDbContext();
    }

    /**
     * @see org.opencms.db.I_CmsDbContextFactory#getDbContext(org.opencms.file.CmsRequestContext)
     */
    @Override
    public CmsDbContext getDbContext(CmsRequestContext context) {

        return new org.opencms.db.jpa.CmsDbContext(context);
    }

    /**
     * @see org.opencms.db.I_CmsDbContextFactory#initialize(org.opencms.db.CmsDriverManager)
     */
    @Override
    public void initialize(CmsDriverManager driverManager) {

        CmsSqlManager.init(driverManager.getPropertyConfiguration());
    }
}
