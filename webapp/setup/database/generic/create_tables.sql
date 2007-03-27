CREATE TABLE CMS_USERS (
	USER_ID VARCHAR2(36) NOT NULL,
	USER_NAME VARCHAR2(64) NOT NULL,
	USER_PASSWORD VARCHAR2(32) NOT NULL,
	USER_DESCRIPTION VARCHAR2(255) NOT NULL,
	USER_FIRSTNAME VARCHAR2(50) NOT NULL,
	USER_LASTNAME VARCHAR2(50) NOT NULL,
	USER_EMAIL VARCHAR2(100) NOT NULL,
	USER_LASTLOGIN DATE NOT NULL,
	USER_FLAGS INT NOT NULL,
	USER_INFO LONG RAW,
	USER_ADDRESS VARCHAR2(100) NOT NULL,
	USER_TYPE INT NOT NULL,
	PRIMARY KEY(USER_ID),
	UNIQUE(USER_NAME)
);

CREATE TABLE CMS_GROUPS (
	GROUP_ID VARCHAR2(36) NOT NULL,
	PARENT_GROUP_ID VARCHAR2(36) NOT NULL,
	GROUP_NAME VARCHAR2(64) NOT NULL,
	GROUP_DESCRIPTION VARCHAR2(255) NOT NULL,
	GROUP_FLAGS INT NOT NULL,
	PRIMARY KEY(GROUP_ID),
	UNIQUE(GROUP_NAME)
);

CREATE INDEX CMS_GROUPS_01_IDX 
	ON CMS_GROUPS (PARENT_GROUP_ID);

CREATE TABLE CMS_GROUPUSERS (
	GROUP_ID VARCHAR2(36) NOT NULL,
	USER_ID VARCHAR2(36) NOT NULL,
	GROUPUSER_FLAGS INT NOT NULL
);

CREATE INDEX CMS_GROUPUSERS_01_IDX 
	ON CMS_GROUPUSERS (GROUP_ID);

CREATE INDEX CMS_GROUPUSERS_02_IDX 
	ON CMS_GROUPUSERS (USER_ID);
	
CREATE TABLE CMS_PROJECTS (
	PROJECT_ID VARCHAR2(36) NOT NULL,
	PROJECT_NAME VARCHAR2(200) NOT NULL,
	PROJECT_DESCRIPTION VARCHAR2(255) NOT NULL,
	PROJECT_FLAGS INT NOT NULL,
	PROJECT_TYPE INT NOT NULL,
	USER_ID VARCHAR2(36) NOT NULL,
	GROUP_ID VARCHAR2(36) NOT NULL, 
	MANAGERGROUP_ID VARCHAR2(36) NOT NULL,
	DATE_CREATED BIGINT NOT NULL,
	PROJECT_OU VARCHAR(128) NOT NULL,
	PRIMARY KEY (PROJECT_ID), 
	UNIQUE (PROJECT_OU, PROJECT_NAME, DATE_CREATED)
);

CREATE INDEX CMS_PROJECTS_01_IDX
	ON CMS_PROJECTS (PROJECT_FLAGS);
	
CREATE INDEX CMS_PROJECTS_02_IDX
	ON CMS_PROJECTS (GROUP_ID);
	
CREATE INDEX CMS_PROJECTS_03_IDX
	ON CMS_PROJECTS (MANAGERGROUP_ID);
	
CREATE INDEX CMS_PROJECTS_04_IDX
	ON CMS_PROJECTS (USER_ID);
	
CREATE INDEX CMS_PROJECTS_05_IDX
	ON CMS_PROJECTS (PROJECT_OU, PROJECT_NAME);
	
CREATE INDEX CMS_PROJECTS_06_IDX
	ON CMS_PROJECTS (PROJECT_NAME);
	
CREATE INDEX CMS_PROJECTS_07_IDX
	ON CMS_PROJECTS (PROJECT_OU);
	
CREATE TABLE CMS_BACKUP_PROJECTS (
	PROJECT_ID VARCHAR2(36) NOT NULL,
	PROJECT_NAME VARCHAR2(255) NOT NULL,
	PROJECT_DESCRIPTION VARCHAR2(255) NOT NULL,
	PROJECT_TYPE INT NOT NULL,
	USER_ID VARCHAR2(36) NOT NULL,
	GROUP_ID VARCHAR2(36) NOT NULL,
	MANAGERGROUP_ID VARCHAR2(36) NOT NULL,
	DATE_CREATED BIGINT NOT NULL,	
	PUBLISH_TAG INT NOT NULL,
	PROJECT_PUBLISHDATE BIGINT,
	PROJECT_PUBLISHED_BY VARCHAR2(36) NOT NULL,
	PROJECT_PUBLISHED_BY_NAME VARCHAR2(255),
	USER_NAME VARCHAR2(128),
	GROUP_NAME VARCHAR2(128),
	MANAGERGROUP_NAME VARCHAR2(128),	
	PROJECT_OU VARCHAR2(128) NOT NULL,
	PRIMARY KEY (PUBLISH_TAG)
);

CREATE TABLE CMS_PROJECTRESOURCES (
	PROJECT_ID VARCHAR2(36) NOT NULL,
	RESOURCE_PATH VARCHAR2(1024) NOT NULL,
	PRIMARY KEY (PROJECT_ID, RESOURCE_PATH)
);

CREATE INDEX CMS_PROJECTRESOURCES_01_IDX
	ON CMS_PROJECTRESOURCES (RESOURCE_PATH);

CREATE TABLE CMS_BACKUP_PROJECTRESOURCES (
	PUBLISH_TAG INT NOT NULL,
	PROJECT_ID INT NOT NULL,
	RESOURCE_PATH VARCHAR2(1024) NOT NULL,
	PRIMARY KEY (PUBLISH_TAG, PROJECT_ID, RESOURCE_PATH)
);

CREATE TABLE CMS_OFFLINE_PROPERTYDEF (
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_NAME VARCHAR2(64) NOT NULL,
	PRIMARY KEY(PROPERTYDEF_ID),
	UNIQUE(PROPERTYDEF_NAME)
);	

CREATE TABLE CMS_ONLINE_PROPERTYDEF (
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_NAME VARCHAR2(64) NOT NULL,
	PRIMARY KEY(PROPERTYDEF_ID),
	UNIQUE(PROPERTYDEF_NAME)
);

CREATE TABLE CMS_BACKUP_PROPERTYDEF (
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_NAME VARCHAR2(64) NOT NULL,
	PRIMARY KEY(PROPERTYDEF_ID),
	UNIQUE(PROPERTYDEF_NAME)
);

CREATE TABLE CMS_OFFLINE_PROPERTIES (
	PROPERTY_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,	
	PROPERTY_VALUE VARCHAR2(255) NOT NULL,
	PRIMARY KEY(PROPERTY_ID)
);

CREATE INDEX CMS_OFFLINE_PROPERTIES_01_IDX
	ON CMS_OFFLINE_PROPERTIES (PROPERTYDEF_ID);
	
CREATE INDEX CMS_OFFLINE_PROPERTIES_02_IDX
	ON CMS_OFFLINE_PROPERTIES (PROPERTY_MAPPING_ID);
	
CREATE INDEX CMS_OFFLINE_PROPERTIES_03_IDX
	ON CMS_OFFLINE_PROPERTIES (PROPERTYDEF_ID, PROPERTY_MAPPING_ID);	

CREATE TABLE CMS_ONLINE_PROPERTIES (
	PROPERTY_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,	
	PROPERTY_VALUE VARCHAR2(255) NOT NULL,
	PRIMARY KEY(PROPERTY_ID)
);

CREATE INDEX CMS_ONLINE_PROPERTIES_01_IDX
	ON CMS_ONLINE_PROPERTIES (PROPERTYDEF_ID);
	
CREATE INDEX CMS_ONLINE_PROPERTIES_02_IDX
	ON CMS_ONLINE_PROPERTIES (PROPERTY_MAPPING_ID);
	
CREATE INDEX CMS_ONLINE_PROPERTIES_03_IDX
	ON CMS_ONLINE_PROPERTIES (PROPERTYDEF_ID, PROPERTY_MAPPING_ID);

CREATE TABLE CMS_BACKUP_PROPERTIES (
	PROPERTY_ID VARCHAR2(36) NOT NULL,
	PROPERTYDEF_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_ID VARCHAR2(36) NOT NULL,
	PROPERTY_MAPPING_TYPE INT NOT NULL,		
	PROPERTY_VALUE VARCHAR2(255) NOT NULL,
	VERSION_ID INT,
	PRIMARY KEY(PROPERTY_ID)
);

CREATE INDEX CMS_BACKUP_PROPERTIES_01_IDX
	ON CMS_BACKUP_PROPERTIES (PROPERTYDEF_ID);
	
CREATE INDEX CMS_BACKUP_PROPERTIES_02_IDX
	ON CMS_BACKUP_PROPERTIES (PROPERTY_MAPPING_ID);
	
CREATE INDEX CMS_BACKUP_PROPERTIES_03_IDX
	ON CMS_BACKUP_PROPERTIES (PROPERTYDEF_ID, PROPERTY_MAPPING_ID);

CREATE TABLE CMS_ONLINE_ACCESSCONTROL (
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	PRINCIPAL_ID VARCHAR2(36) NOT NULL,
	ACCESS_ALLOWED INT,
	ACCESS_DENIED INT,
	ACCESS_FLAGS INT,
	PRIMARY KEY(RESOURCE_ID, PRINCIPAL_ID)
);

CREATE TABLE CMS_OFFLINE_ACCESSCONTROL (
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	PRINCIPAL_ID VARCHAR2(36) NOT NULL,
	ACCESS_ALLOWED INT,
	ACCESS_DENIED INT,
	ACCESS_FLAGS INT,
	PRIMARY KEY(RESOURCE_ID, PRINCIPAL_ID)
);

CREATE TABLE CMS_PUBLISH_HISTORY (
	HISTORY_ID VARCHAR(36) NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	STRUCTURE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_PATH VARCHAR2(1024) NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,
	CONSTRAINT PK_PUBLISH_HISTORY PRIMARY KEY(HISTORY_ID,PUBLISH_TAG,STRUCTURE_ID,RESOURCE_PATH)
);

CREATE TABLE CMS_PUBLISH_JOBS (
	HISTORY_ID VARCHAR2(36) NOT NULL,
	PROJECT_ID VARCHAR2(36)NOT NULL,
	PROJECT_NAME VARCHAR2(64) NOT NULL,
	USER_ID VARCHAR2(36) NOT NULL,
	USER_NAME VARCHAR2(64) NOT NULL,
	PUBLISH_LOCALE VARCHAR(16) NOT NULL,
	PUBLISH_FLAGS INT NOT NULL,
	PUBLISH_LIST BLOB,
	REPORT_PATH TEXT NOT NULL,
	RESOURCE_COUNT INT NOT NULL,
	ENQUEUE_TIME NUMBER NOT NULL,
	START_TIME NUMBER NOT NULL,
	FINISH_TIME NUMBER NOT NULL,
	PRIMARY KEY(HISTORY_ID)
);	

CREATE TABLE CMS_RESOURCE_LOCKS (
  RESOURCE_PATH VARCHAR2(1024) NOT NULL,
  USER_ID VARCHAR2(36) NOT NULL,
  PROJECT_ID VARCHAR2(36) NOT NULL,
  LOCK_TYPE INT NOT NULL
);

CREATE TABLE CMS_STATICEXPORT_LINKS (
	LINK_ID VARCHAR(36) NOT NULL,
	LINK_RFS_PATH VARCHAR(1024) NOT NULL,
	LINK_TYPE INT NOT NULL,
	LINK_PARAMETER VARCHAR(1024),
	LINK_TIMESTAMP NUMBER NOT NULL,
	PRIMARY KEY(LINK_ID)
);

CREATE INDEX CMS_STATICEXPORT_LINKS_IDX
    ON CMS_STATICEXPORT_LINKS (LINK_RFS_PATH);

CREATE TABLE CMS_OFFLINE_STRUCTURE (
	STRUCTURE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	PARENT_ID VARCHAR2(36) NOT NULL,
	RESOURCE_PATH VARCHAR2(1024) NOT NULL,
	STRUCTURE_STATE INT NOT NULL,
	DATE_RELEASED DATE NOT NULL,
	DATE_EXPIRED DATE NOT NULL,
	PRIMARY KEY(STRUCTURE_ID)
);

CREATE INDEX CMS_OFFLINE_STRUCTURE_01_IDX
	ON CMS_OFFLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_PATH);
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_02_IDX
	ON CMS_OFFLINE_STRUCTURE (RESOURCE_PATH, RESOURCE_ID);
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_03_IDX
	ON CMS_OFFLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_ID);
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_04_IDX
	ON CMS_OFFLINE_STRUCTURE (STRUCTURE_STATE);
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_05_IDX
	ON CMS_OFFLINE_STRUCTURE (PARENT_ID);
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_06_IDX
	ON CMS_OFFLINE_STRUCTURE (RESOURCE_ID);
	
CREATE INDEX CMS_OFFLINE_STRUCTURE_07_IDX
	ON CMS_OFFLINE_STRUCTURE (RESOURCE_PATH);	

CREATE TABLE CMS_ONLINE_STRUCTURE (
	STRUCTURE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	PARENT_ID VARCHAR2(36) NOT NULL,
	RESOURCE_PATH VARCHAR2(1024) NOT NULL,
	STRUCTURE_STATE INT NOT NULL,	
	DATE_RELEASED DATE NOT NULL,
	DATE_EXPIRED DATE NOT NULL,
	PRIMARY KEY(STRUCTURE_ID)
);

CREATE INDEX CMS_ONLINE_STRUCTURE_01_IDX
	ON CMS_ONLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_PATH);
	
CREATE INDEX CMS_ONLINE_STRUCTURE_02_IDX
	ON CMS_ONLINE_STRUCTURE (RESOURCE_PATH, RESOURCE_ID);
	
CREATE INDEX CMS_ONLINE_STRUCTURE_03_IDX
	ON CMS_ONLINE_STRUCTURE (STRUCTURE_ID, RESOURCE_ID);
	
CREATE INDEX CMS_ONLINE_STRUCTURE_04_IDX
	ON CMS_ONLINE_STRUCTURE (STRUCTURE_STATE);
	
CREATE INDEX CMS_ONLINE_STRUCTURE_05_IDX
	ON CMS_ONLINE_STRUCTURE (PARENT_ID);
	
CREATE INDEX CMS_ONLINE_STRUCTURE_06_IDX
	ON CMS_ONLINE_STRUCTURE (RESOURCE_ID);
	
CREATE INDEX CMS_ONLINE_STRUCTURE_07_IDX
	ON CMS_ONLINE_STRUCTURE (RESOURCE_PATH);

CREATE TABLE CMS_BACKUP_STRUCTURE (
	BACKUP_ID VARCHAR2(36) NOT NULL,
	VERSION_ID INT NOT NULL,
	STRUCTURE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_PATH VARCHAR2(1024) NOT NULL,
	STRUCTURE_STATE INT NOT NULL,
	DATE_RELEASED DATE NOT NULL,
	DATE_EXPIRED DATE NOT NULL,
	PRIMARY KEY(BACKUP_ID)
);   

CREATE INDEX CMS_BACKUP_STRUCTURE_01_IDX
	ON CMS_BACKUP_STRUCTURE (STRUCTURE_ID, RESOURCE_PATH);
	
CREATE INDEX CMS_BACKUP_STRUCTURE_02_IDX
	ON CMS_BACKUP_STRUCTURE (RESOURCE_PATH, RESOURCE_ID);
	
CREATE INDEX CMS_BACKUPE_STRUCTURE_03_IDX
	ON CMS_BACKUP_STRUCTURE (STRUCTURE_ID, RESOURCE_ID);
	
CREATE INDEX CMS_BACKUP_STRUCTURE_04_IDX
	ON CMS_BACKUP_STRUCTURE (STRUCTURE_STATE);
	
CREATE INDEX CMS_BACKUP_STRUCTURE_05_IDX
	ON CMS_BACKUP_STRUCTURE (RESOURCE_ID);
	
CREATE INDEX CMS_BACKUP_STRUCTURE_07_IDX
	ON CMS_BACKUP_STRUCTURE (RESOURCE_PATH);

CREATE TABLE CMS_OFFLINE_RESOURCES (
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,	
	DATE_CREATED DATE NOT NULL,
	DATE_LASTMODIFIED BIGINT NOT NULL,
	USER_CREATED VARCHAR2(36) NOT NULL,
	USER_LASTMODIFIED VARCHAR2(36) NOT NULL,
	PROJECT_LASTMODIFIED VARCHAR2(36) NOT NULL,
	PRIMARY KEY(RESOURCE_ID)
);

CREATE INDEX CMS_OFFLINE_RESOURCES_01_IDX
	ON CMS_OFFLINE_RESOURCES (PROJECT_LASTMODIFIED);

CREATE INDEX CMS_OFFLINE_RESOURCES_02_IDX
	ON CMS_OFFLINE_RESOURCES (PROJECT_LASTMODIFIED, RESOURCE_SIZE);

CREATE INDEX CMS_OFFLINE_RESOURCES_03_IDX
	ON CMS_OFFLINE_RESOURCES (RESOURCE_SIZE);
	
CREATE INDEX CMS_OFFLINE_RESOURCES_04_IDX
	ON CMS_OFFLINE_RESOURCES (DATE_LASTMODIFIED);
	
CREATE INDEX CMS_OFFLINE_RESOURCES_05_IDX
	ON CMS_OFFLINE_RESOURCES (RESOURCE_TYPE);	

CREATE TABLE CMS_ONLINE_RESOURCES (
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,	
	DATE_CREATED DATE NOT NULL,
	DATE_LASTMODIFIED BIGINT NOT NULL,
	USER_CREATED VARCHAR2(36) NOT NULL,
	USER_LASTMODIFIED VARCHAR2(36) NOT NULL,
	PROJECT_LASTMODIFIED VARCHAR2(36) NOT NULL,
	PRIMARY KEY(RESOURCE_ID)
);

CREATE INDEX CMS_ONLINE_RESOURCES_01_IDX
	ON CMS_ONLINE_RESOURCES (PROJECT_LASTMODIFIED);

CREATE INDEX CMS_ONLINE_RESOURCES_02_IDX
	ON CMS_ONLINE_RESOURCES (PROJECT_LASTMODIFIED, RESOURCE_SIZE);

CREATE INDEX CMS_ONLINE_RESOURCES_03_IDX
	ON CMS_ONLINE_RESOURCES (RESOURCE_SIZE);
	
CREATE INDEX CMS_ONLINE_RESOURCES_04_IDX
	ON CMS_ONLINE_RESOURCES (DATE_LASTMODIFIED);
	
CREATE INDEX CMS_ONLINE_RESOURCES_05_IDX
	ON CMS_ONLINE_RESOURCES (RESOURCE_TYPE);

CREATE TABLE CMS_BACKUP_RESOURCES (
	BACKUP_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	RESOURCE_TYPE INT NOT NULL,
	RESOURCE_FLAGS INT NOT NULL,
	RESOURCE_STATE INT NOT NULL,
	RESOURCE_SIZE INT NOT NULL,
	SIBLING_COUNT INT NOT NULL,	
	DATE_CREATED DATE NOT NULL,
	DATE_LASTMODIFIED BIGINT NOT NULL,
	USER_CREATED VARCHAR2(36) NOT NULL,
	USER_LASTMODIFIED VARCHAR2(36) NOT NULL,
	PROJECT_LASTMODIFIED VARCHAR2(36) NOT NULL,
	PUBLISH_TAG INT NOT NULL,
	VERSION_ID INT NOT NULL,
	USER_CREATED_NAME VARCHAR2(64) NOT NULL,
	USER_LASTMODIFIED_NAME VARCHAR2(64) NOT NULL,
	PRIMARY KEY(BACKUP_ID),
	UNIQUE(VERSION_ID,RESOURCE_ID)
);

CREATE INDEX CMS_BACKUP_RESOURCES_01_IDX
	ON CMS_BACKUP_RESOURCES (PROJECT_LASTMODIFIED);
	
CREATE INDEX CMS_BACKUP_RESOURCES_02_IDX
	ON CMS_BACKUP_RESOURCES (PROJECT_LASTMODIFIED, RESOURCE_SIZE);
	
CREATE INDEX CMS_BACKUP_RESOURCES_03_IDX
	ON CMS_BACKUP_RESOURCES (RESOURCE_SIZE);
	
CREATE INDEX CMS_BACKUP_RESOURCES_04_IDX
	ON CMS_BACKUP_RESOURCES (DATE_LASTMODIFIED);
	
CREATE INDEX CMS_BACKUP_RESOURCES_05_IDX
	ON CMS_BACKUP_RESOURCES (RESOURCE_TYPE);	

CREATE TABLE CMS_OFFLINE_CONTENTS (
	CONTENT_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	FILE_CONTENT BLOB NOT NULL,
	PRIMARY KEY (CONTENT_ID)
);

CREATE INDEX CMS_OFFLINE_CONTENTS_01_IDX
	ON CMS_OFFLINE_CONTENTS (RESOURCE_ID);

CREATE TABLE CMS_ONLINE_CONTENTS (
	CONTENT_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	FILE_CONTENT BLOB NOT NULL,
	PRIMARY KEY (CONTENT_ID)
);

CREATE INDEX CMS_ONLINE_CONTENTS_01_IDX
	ON CMS_ONLINE_CONTENTS (RESOURCE_ID);

CREATE TABLE CMS_BACKUP_CONTENTS (
	BACKUP_ID VARCHAR2(36) NOT NULL,
	CONTENT_ID VARCHAR2(36) NOT NULL,
	RESOURCE_ID VARCHAR2(36) NOT NULL,
	FILE_CONTENT BLOB NOT NULL,
	VERSION_ID INT,
	PRIMARY KEY (BACKUP_ID)
);

CREATE INDEX CMS_BACKUP_CONTENTS_01_IDX
	ON CMS_BACKUP_CONTENTS (RESOURCE_ID);

CREATE TABLE CMS_ONLINE_RESOURCE_RELATIONS (
	RELATION_SOURCE_ID VARCHAR(36) NOT NULL,
	RELATION_SOURCE_PATH VARCHAR2(1024) NOT NULL,
	RELATION_TARGET_ID VARCHAR(36) NOT NULL,
	RELATION_TARGET_PATH VARCHAR2(1024) NOT NULL,
	RELATION_DATE_BEGIN NUMBER NOT NULL,
	RELATION_DATE_END NUMBER NOT NULL,
	RELATION_TYPE INT NOT NULL
);

CREATE INDEX CMS_ONLINE_RELATIONS_01_IDX
	ON CMS_ONLINE_RESOURCE_RELATIONS (RELATION_SOURCE_ID);
	
CREATE INDEX CMS_ONLINE_RELATIONS_02_IDX
	ON CMS_ONLINE_RESOURCE_RELATIONS (RELATION_TARGET_ID);
	
CREATE INDEX CMS_ONLINE_RELATIONS_03_IDX
	ON CMS_ONLINE_RESOURCE_RELATIONS (RELATION_SOURCE_PATH);
	
CREATE INDEX CMS_ONLINE_RELATIONS_04_IDX
	ON CMS_ONLINE_RESOURCE_RELATIONS (RELATION_TARGET_PATH);

CREATE TABLE CMS_OFFLINE_RESOURCE_RELATIONS (
	RELATION_SOURCE_ID VARCHAR(36) NOT NULL,
	RELATION_SOURCE_PATH VARCHAR2(1024) NOT NULL,
	RELATION_TARGET_ID VARCHAR(36) NOT NULL,
	RELATION_TARGET_PATH VARCHAR2(1024) NOT NULL,
	RELATION_DATE_BEGIN NUMBER NOT NULL,
	RELATION_DATE_END NUMBER NOT NULL,
	RELATION_TYPE INT NOT NULL
);

CREATE INDEX CMS_OFFLINE_RELATIONS_01_IDX
	ON CMS_OFFLINE_RESOURCE_RELATIONS (RELATION_SOURCE_ID);
	
CREATE INDEX CMS_OFFLINE_RELATIONS_02_IDX
	ON CMS_OFFLINE_RESOURCE_RELATIONS (RELATION_TARGET_ID);
	
CREATE INDEX CMS_OFFLINE_RELATIONS_03_IDX
	ON CMS_OFFLINE_RESOURCE_RELATIONS (RELATION_SOURCE_PATH);

CREATE INDEX CMS_OFFLINE_RELATIONS_04_IDX
	ON CMS_OFFLINE_RESOURCE_RELATIONS (RELATION_TARGET_PATH);
	