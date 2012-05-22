/*
 * This library is part of OpenCms -
 * the Open Source Content Management System
 *
 * Copyright (C) Alkacon Software (http://www.alkacon.com)
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

package org.opencms.db;

import org.opencms.file.CmsObject;
import org.opencms.file.CmsResource;
import org.opencms.file.types.CmsResourceTypePlain;
import org.opencms.gwt.shared.CmsAliasMode;
import org.opencms.main.OpenCms;
import org.opencms.test.OpenCmsTestCase;
import org.opencms.test.OpenCmsTestProperties;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import junit.framework.Test;

import com.google.common.collect.MapDifference;
import com.google.common.collect.Maps;

public class TestAliases extends OpenCmsTestCase {

    public TestAliases(String name) {

        super(name);
    }

    public static Test suite() {

        OpenCmsTestProperties.initialize(org.opencms.test.AllTests.TEST_PROPERTIES_PATH);
        return generateSetupTestWrapper(TestAliases.class, "systemtest", "/");
    }

    public void checkAliases(CmsResource resource, String... aliasPaths) throws Exception {
        List<CmsAlias> aliases = OpenCms.getAliasManager().getAliasesForStructureId(getCmsObject(), resource.getStructureId());
        Map<String, Boolean> aliasMapFromDb = new HashMap<String, Boolean>();
        for (CmsAlias alias: aliases) {
            aliasMapFromDb.put(alias.getAliasPath(), Boolean.TRUE);
        }
        Map<String, Boolean> aliasMapFromParameters = new HashMap<String, Boolean>();
        for (String aliasPath: aliasPaths) {
            aliasMapFromParameters.put(aliasPath, Boolean.TRUE);
        }
        MapDifference<String, Boolean> difference = Maps.difference(aliasMapFromDb, aliasMapFromParameters);
       assertTrue("Aliases for " + resource.getRootPath() + " (left) don't match expected aliases (right): " + difference.toString(), difference.areEqual());
    }

    public void testAddAlias() throws Exception {

        CmsObject cms = getCmsObject();
        CmsAliasManager aliasManager = OpenCms.getAliasManager();
        CmsResource foo1 = cms.createResource("/system/foo1", CmsResourceTypePlain.getStaticTypeId());
        CmsResource bar1 = cms.createResource("/system/bar1", CmsResourceTypePlain.getStaticTypeId());
        CmsAlias alias = new CmsAlias(foo1.getStructureId(), "", "/xyzzy1", CmsAliasMode.page);
        CmsAlias alias2 = new CmsAlias(bar1.getStructureId(), "", "/xyzzy2", CmsAliasMode.page);
        aliasManager.saveAliases(cms,  foo1.getStructureId(), Collections.singletonList(alias));
        aliasManager.saveAliases(cms,  bar1.getStructureId(), Collections.singletonList(alias2));
        checkAliases(foo1, "/xyzzy1");
        checkAliases(bar1, "/xyzzy2");
        CmsAlias alias3 = new CmsAlias(foo1.getStructureId(), "", "/xyzzy3", CmsAliasMode.page);
        CmsAlias alias4 = new CmsAlias(foo1.getStructureId(), "", "/xyzzy4", CmsAliasMode.page);
        List<CmsAlias> aliases = new ArrayList<CmsAlias>();
        aliases.add(alias3);
        aliases.add(alias4);
        aliasManager.saveAliases(cms, foo1.getStructureId(), aliases);
        checkAliases(foo1, "/xyzzy3", "/xyzzy4");
        checkAliases(bar1, "/xyzzy2");
    }
}
