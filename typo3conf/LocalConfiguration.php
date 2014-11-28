<?php
return array(
	'BE' => array(
		'debug' => TRUE,
		'explicitADmode' => 'explicitAllow',
		'installToolPassword' => '$P$CqqGCG0k4C/WcuyWNmvi47B53jJrVa.',
		'loginSecurityLevel' => 'rsa',
		'versionNumberInFilename' => '0',
	),
	'DB' => array(
		'database' => 'typo3',
		'extTablesDefinitionScript' => 'extTables.php',
		'host' => 'localhost',
		'password' => 'rootpass',
		'socket' => '',
		'username' => 'root',
	),
	'EXT' => array(
		'extConf' => array(
			'rsaauth' => 'a:1:{s:18:"temporaryDirectory";s:0:"";}',
			'saltedpasswords' => 'a:2:{s:3:"BE.";a:4:{s:21:"saltedPWHashingMethod";s:41:"TYPO3\\CMS\\Saltedpasswords\\Salt\\PhpassSalt";s:11:"forceSalted";i:0;s:15:"onlyAuthService";i:0;s:12:"updatePasswd";i:1;}s:3:"FE.";a:5:{s:7:"enabled";i:1;s:21:"saltedPWHashingMethod";s:41:"TYPO3\\CMS\\Saltedpasswords\\Salt\\PhpassSalt";s:11:"forceSalted";i:0;s:15:"onlyAuthService";i:0;s:12:"updatePasswd";i:1;}}',
		),
	),
	'FE' => array(
		'activateContentAdapter' => FALSE,
		'debug' => TRUE,
		'loginSecurityLevel' => 'rsa',
	),
	'GFX' => array(
		'colorspace' => 'RGB',
		'im' => '1',
		'im_mask_temp_ext_gif' => '1',
		'im_path' => '/usr/bin/',
		'im_path_lzw' => '/usr/bin/',
		'im_v5effects' => '0',
		'im_version_5' => 'im6',
		'image_processing' => '1',
		'jpg_quality' => '80',
	),
	'SYS' => array(
		'caching' => array(
			'cacheConfigurations' => array(
				'extbase_object' => array(
					'backend' => 'TYPO3\\CMS\\Core\\Cache\\Backend\\Typo3DatabaseBackend',
					'frontend' => 'TYPO3\\CMS\\Core\\Cache\\Frontend\\VariableFrontend',
					'groups' => array(
						'system',
					),
					'options' => array(
						'defaultLifetime' => 0,
					),
				),
			),
		),
		'clearCacheSystem' => TRUE,
		'compat_version' => '6.2',
		'curlUse' => '1',
		'devIPmask' => '*',
		'displayErrors' => 1,
		'enableDeprecationLog' => 'file',
		'encryptionKey' => 'f87d6184a9b1ff20270207ba831cb370af00875c3cf1bb575cbf94fd781508a1d39729c1a83d2904e4ebb76eff854bf2',
		'exceptionalErrors' => 28674,
		'isInitialInstallationInProgress' => FALSE,
		'sitename' => 'New TYPO3 site',
		'sqlDebug' => 1,
		'systemLogLevel' => 0,
		't3lib_cs_convMethod' => 'mbstring',
		't3lib_cs_utils' => 'mbstring',
	),
);
?>