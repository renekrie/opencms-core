/*
 * File   : $Source: /alkacon/cvs/opencms/src-modules/org/opencms/ade/galleries/client/Attic/CmsSitemapTabHandler.java,v $
 * Date   : $Date: 2010/11/29 10:33:35 $
 * Version: $Revision: 1.3 $
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

package org.opencms.ade.galleries.client;

import org.opencms.ade.galleries.shared.CmsSitemapEntryBean;

import java.util.List;

import com.google.gwt.user.client.rpc.AsyncCallback;

/**
 * The tab handler class for the sitemap tab.<p>
 * 
 * @author Georg Westenberger
 * 
 * @version $Revision: 1.3 $
 * 
 * @since 8.0.0
 */
public class CmsSitemapTabHandler extends A_CmsTabHandler {

    /**
     * Constructor.<p>
     * 
     * @param controller the gallery controller 
     */
    public CmsSitemapTabHandler(CmsGalleryController controller) {

        super(controller);
    }

    /**
     * @see org.opencms.ade.galleries.client.A_CmsTabHandler#clearParams()
     */
    @Override
    public void clearParams() {

        // nothing to do here, does not apply to the sitemap tab
    }

    /**
     * Retrieves the sub-entries for a given sitemap path and passes them to a callback asynchronously.<p>
     * 
     * @param path the path for which the sitemap entries should be retrieved 
     * @param callback
     */
    public void getSubEntries(String path, AsyncCallback<List<CmsSitemapEntryBean>> callback) {

        m_controller.getSitemapSubEntries(path, callback);
    }

    /**
     * @see org.opencms.ade.galleries.client.A_CmsTabHandler#onSelection()
     */
    @Override
    public void onSelection() {

        //do nothing

    }

    /**
     * @see org.opencms.ade.galleries.client.A_CmsTabHandler#onSort(java.lang.String)
     */
    @Override
    public void onSort(String sortParams) {

        //do nothing
    }

    /**
     * The function that should be called when a resource is selected.<p> 
     * 
     * @param resourcePath the resource path 
     * @param title the title 
     * @param resourceType the resource type 
     */
    public void selectResource(String resourcePath, String title, String resourceType) {

        m_controller.selectResource(resourcePath, title, resourceType);
    }

}
