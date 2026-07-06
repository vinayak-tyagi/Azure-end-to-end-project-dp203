@secure()
param vulnerabilityAssessments_Default_storageContainerPath string
param servers_de_sql_practice_server_name string = 'de-sql-practice-server'
param storageAccounts_destoragepractice_name string = 'destoragepractice'

resource servers_de_sql_practice_server_name_resource 'Microsoft.Sql/servers@2025-02-01-preview' = {
  name: servers_de_sql_practice_server_name
  location: 'centralindia'
  kind: 'v12.0'
  properties: {
    administratorLogin: 'ITCMITEAM'
    version: '12.0'
    minimalTlsVersion: '1.2'
    publicNetworkAccess: 'Enabled'
    restrictOutboundNetworkAccess: 'Disabled'
    retentionDays: -1
  }
}

resource storageAccounts_destoragepractice_name_resource 'Microsoft.Storage/storageAccounts@2026-04-01' = {
  name: storageAccounts_destoragepractice_name
  location: 'southindia'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  kind: 'StorageV2'
  properties: {
    dualStackEndpointPreference: {
      publishIpv6Endpoint: false
    }
    dnsEndpointType: 'Standard'
    defaultToOAuthAuthentication: false
    publicNetworkAccess: 'Enabled'
    allowCrossTenantReplication: false
    minimumTlsVersion: 'TLS1_2'
    allowBlobPublicAccess: false
    allowSharedKeyAccess: true
    networkAcls: {
      ipv6Rules: []
      bypass: 'AzureServices'
      virtualNetworkRules: []
      ipRules: []
      defaultAction: 'Allow'
    }
    supportsHttpsTrafficOnly: true
    encryption: {
      requireInfrastructureEncryption: false
      services: {
        file: {
          keyType: 'Account'
          enabled: true
        }
        blob: {
          keyType: 'Account'
          enabled: true
        }
      }
      keySource: 'Microsoft.Storage'
    }
    accessTier: 'Hot'
  }
}

resource servers_de_sql_practice_server_name_Default 'Microsoft.Sql/servers/advancedThreatProtectionSettings@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource servers_de_sql_practice_server_name_CreateIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'CreateIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_de_sql_practice_server_name_DbParameterization 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'DbParameterization'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_de_sql_practice_server_name_DefragmentIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'DefragmentIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_de_sql_practice_server_name_DropIndex 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'DropIndex'
  properties: {
    autoExecuteValue: 'Disabled'
  }
}

resource servers_de_sql_practice_server_name_ForceLastGoodPlan 'Microsoft.Sql/servers/advisors@2014-04-01' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'ForceLastGoodPlan'
  properties: {
    autoExecuteValue: 'Enabled'
  }
}

resource Microsoft_Sql_servers_auditingPolicies_servers_de_sql_practice_server_name_Default 'Microsoft.Sql/servers/auditingPolicies@2014-04-01' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'Default'
  location: 'Central India'
  properties: {
    auditingState: 'Disabled'
  }
}

resource Microsoft_Sql_servers_auditingSettings_servers_de_sql_practice_server_name_Default 'Microsoft.Sql/servers/auditingSettings@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'Default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource Microsoft_Sql_servers_connectionPolicies_servers_de_sql_practice_server_name_default 'Microsoft.Sql/servers/connectionPolicies@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'default'
  location: 'centralindia'
  properties: {
    connectionType: 'Default'
  }
}

resource servers_de_sql_practice_server_name_de_crps_free_sql_db 'Microsoft.Sql/servers/databases@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'de-crps-free-sql-db'
  location: 'centralindia'
  sku: {
    name: 'GP_S_Gen5_2'
    tier: 'GeneralPurpose'
    family: 'Gen5'
    capacity: 2
  }
  kind: 'v12.0,user,vcore,serverless,freelimit'
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: 34359738368
    catalogCollation: 'SQL_Latin1_General_CP1_CI_AS'
    zoneRedundant: false
    readScale: 'Disabled'
    autoPauseDelay: 60
    requestedBackupStorageRedundancy: 'Local'
    minCapacity: json('0.5')
    maintenanceConfigurationId: '/subscriptions/0c0802dd-29a9-49a8-a292-7072cd6b8980/providers/Microsoft.Maintenance/publicMaintenanceConfigurations/SQL_Default'
    isLedgerOn: false
    useFreeLimit: true
    freeLimitExhaustionBehavior: 'AutoPause'
    availabilityZone: 'NoPreference'
  }
}

resource servers_de_sql_practice_server_name_master_Default 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2025-02-01-preview' = {
  name: '${servers_de_sql_practice_server_name}/master/Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingPolicies_servers_de_sql_practice_server_name_master_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  name: '${servers_de_sql_practice_server_name}/master/Default'
  location: 'Central India'
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_servers_de_sql_practice_server_name_master_Default 'Microsoft.Sql/servers/databases/auditingSettings@2025-02-01-preview' = {
  name: '${servers_de_sql_practice_server_name}/master/Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_servers_de_sql_practice_server_name_master_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2025-02-01-preview' = {
  name: '${servers_de_sql_practice_server_name}/master/Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_servers_de_sql_practice_server_name_master_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2025-02-01-preview' = {
  name: '${servers_de_sql_practice_server_name}/master/Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource servers_de_sql_practice_server_name_master_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2025-02-01-preview' = {
  name: '${servers_de_sql_practice_server_name}/master/Current'
  properties: {}
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_servers_de_sql_practice_server_name_master_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2025-02-01-preview' = {
  name: '${servers_de_sql_practice_server_name}/master/Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_servers_de_sql_practice_server_name_master_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2025-02-01-preview' = {
  name: '${servers_de_sql_practice_server_name}/master/Current'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_servers_de_sql_practice_server_name_master_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2025-02-01-preview' = {
  name: '${servers_de_sql_practice_server_name}/master/Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_devOpsAuditingSettings_servers_de_sql_practice_server_name_Default 'Microsoft.Sql/servers/devOpsAuditingSettings@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'Default'
  properties: {
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource servers_de_sql_practice_server_name_current 'Microsoft.Sql/servers/encryptionProtector@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'current'
  kind: 'servicemanaged'
  properties: {
    serverKeyName: 'ServiceManaged'
    serverKeyType: 'ServiceManaged'
    autoRotationEnabled: false
  }
}

resource Microsoft_Sql_servers_extendedAuditingSettings_servers_de_sql_practice_server_name_Default 'Microsoft.Sql/servers/extendedAuditingSettings@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'Default'
  properties: {
    retentionDays: 0
    auditActionsAndGroups: []
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: false
    isManagedIdentityInUse: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
}

resource servers_de_sql_practice_server_name_AllowAllWindowsAzureIps 'Microsoft.Sql/servers/firewallRules@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'AllowAllWindowsAzureIps'
  properties: {
    startIpAddress: '0.0.0.0'
    endIpAddress: '0.0.0.0'
  }
}

resource servers_de_sql_practice_server_name_query_editor_0c3070 'Microsoft.Sql/servers/firewallRules@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'query-editor-0c3070'
  properties: {
    startIpAddress: '171.76.87.16'
    endIpAddress: '171.76.87.16'
  }
}

resource servers_de_sql_practice_server_name_QueryEditorClientIPAddress_1783234048487 'Microsoft.Sql/servers/firewallRules@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'QueryEditorClientIPAddress_1783234048487'
  properties: {
    startIpAddress: '171.76.85.134'
    endIpAddress: '171.76.85.134'
  }
}

resource servers_de_sql_practice_server_name_ServiceManaged 'Microsoft.Sql/servers/keys@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'ServiceManaged'
  kind: 'servicemanaged'
  properties: {
    serverKeyType: 'ServiceManaged'
  }
}

resource Microsoft_Sql_servers_securityAlertPolicies_servers_de_sql_practice_server_name_Default 'Microsoft.Sql/servers/securityAlertPolicies@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
}

resource Microsoft_Sql_servers_sqlVulnerabilityAssessments_servers_de_sql_practice_server_name_Default 'Microsoft.Sql/servers/sqlVulnerabilityAssessments@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
}

resource Microsoft_Sql_servers_vulnerabilityAssessments_servers_de_sql_practice_server_name_Default 'Microsoft.Sql/servers/vulnerabilityAssessments@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_resource
  name: 'Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
    storageContainerPath: vulnerabilityAssessments_Default_storageContainerPath
  }
}

resource storageAccounts_destoragepractice_name_default 'Microsoft.Storage/storageAccounts/blobServices@2026-04-01' = {
  parent: storageAccounts_destoragepractice_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    staticWebsite: {
      enabled: false
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
    cors: {
      corsRules: []
    }
    deleteRetentionPolicy: {
      allowPermanentDelete: false
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_fileServices_storageAccounts_destoragepractice_name_default 'Microsoft.Storage/storageAccounts/fileServices@2026-04-01' = {
  parent: storageAccounts_destoragepractice_name_resource
  name: 'default'
  sku: {
    name: 'Standard_LRS'
    tier: 'Standard'
  }
  properties: {
    protocolSettings: {
      smb: {
        encryptionInTransit: {
          required: true
        }
      }
    }
    cors: {
      corsRules: []
    }
    shareDeleteRetentionPolicy: {
      enabled: true
      days: 7
    }
  }
}

resource Microsoft_Storage_storageAccounts_queueServices_storageAccounts_destoragepractice_name_default 'Microsoft.Storage/storageAccounts/queueServices@2026-04-01' = {
  parent: storageAccounts_destoragepractice_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource Microsoft_Storage_storageAccounts_tableServices_storageAccounts_destoragepractice_name_default 'Microsoft.Storage/storageAccounts/tableServices@2026-04-01' = {
  parent: storageAccounts_destoragepractice_name_resource
  name: 'default'
  properties: {
    cors: {
      corsRules: []
    }
  }
}

resource servers_de_sql_practice_server_name_de_crps_free_sql_db_Default 'Microsoft.Sql/servers/databases/advancedThreatProtectionSettings@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingPolicies_servers_de_sql_practice_server_name_de_crps_free_sql_db_Default 'Microsoft.Sql/servers/databases/auditingPolicies@2014-04-01' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'Default'
  location: 'Central India'
  properties: {
    auditingState: 'Disabled'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_auditingSettings_servers_de_sql_practice_server_name_de_crps_free_sql_db_Default 'Microsoft.Sql/servers/databases/auditingSettings@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_backupLongTermRetentionPolicies_servers_de_sql_practice_server_name_de_crps_free_sql_db_default 'Microsoft.Sql/servers/databases/backupLongTermRetentionPolicies@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'default'
  properties: {
    timeBasedImmutability: 'Disabled'
    weeklyRetention: 'PT0S'
    monthlyRetention: 'PT0S'
    yearlyRetention: 'PT0S'
    weekOfYear: 0
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_backupShortTermRetentionPolicies_servers_de_sql_practice_server_name_de_crps_free_sql_db_default 'Microsoft.Sql/servers/databases/backupShortTermRetentionPolicies@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'default'
  properties: {
    retentionDays: 7
    diffBackupIntervalInHours: 12
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_extendedAuditingSettings_servers_de_sql_practice_server_name_de_crps_free_sql_db_Default 'Microsoft.Sql/servers/databases/extendedAuditingSettings@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'Default'
  properties: {
    retentionDays: 0
    isAzureMonitorTargetEnabled: false
    state: 'Disabled'
    storageAccountSubscriptionId: '00000000-0000-0000-0000-000000000000'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_geoBackupPolicies_servers_de_sql_practice_server_name_de_crps_free_sql_db_Default 'Microsoft.Sql/servers/databases/geoBackupPolicies@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'Default'
  properties: {
    state: 'Disabled'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource servers_de_sql_practice_server_name_de_crps_free_sql_db_Current 'Microsoft.Sql/servers/databases/ledgerDigestUploads@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'Current'
  properties: {}
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_securityAlertPolicies_servers_de_sql_practice_server_name_de_crps_free_sql_db_Default 'Microsoft.Sql/servers/databases/securityAlertPolicies@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'Default'
  properties: {
    state: 'Disabled'
    disabledAlerts: [
      ''
    ]
    emailAddresses: [
      ''
    ]
    emailAccountAdmins: false
    retentionDays: 0
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_transparentDataEncryption_servers_de_sql_practice_server_name_de_crps_free_sql_db_Current 'Microsoft.Sql/servers/databases/transparentDataEncryption@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'Current'
  properties: {
    state: 'Enabled'
    scanState: 'Complete'
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource Microsoft_Sql_servers_databases_vulnerabilityAssessments_servers_de_sql_practice_server_name_de_crps_free_sql_db_Default 'Microsoft.Sql/servers/databases/vulnerabilityAssessments@2025-02-01-preview' = {
  parent: servers_de_sql_practice_server_name_de_crps_free_sql_db
  name: 'Default'
  properties: {
    recurringScans: {
      isEnabled: false
      emailSubscriptionAdmins: true
    }
  }
  dependsOn: [
    servers_de_sql_practice_server_name_resource
  ]
}

resource storageAccounts_destoragepractice_name_default_archive 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-04-01' = {
  parent: storageAccounts_destoragepractice_name_default
  name: 'archive'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_destoragepractice_name_resource
  ]
}

resource storageAccounts_destoragepractice_name_default_curated 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-04-01' = {
  parent: storageAccounts_destoragepractice_name_default
  name: 'curated'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_destoragepractice_name_resource
  ]
}

resource storageAccounts_destoragepractice_name_default_processed 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-04-01' = {
  parent: storageAccounts_destoragepractice_name_default
  name: 'processed'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_destoragepractice_name_resource
  ]
}

resource storageAccounts_destoragepractice_name_default_raw 'Microsoft.Storage/storageAccounts/blobServices/containers@2026-04-01' = {
  parent: storageAccounts_destoragepractice_name_default
  name: 'raw'
  properties: {
    immutableStorageWithVersioning: {
      enabled: false
    }
    defaultEncryptionScope: '$account-encryption-key'
    denyEncryptionScopeOverride: false
    publicAccess: 'None'
  }
  dependsOn: [
    storageAccounts_destoragepractice_name_resource
  ]
}
