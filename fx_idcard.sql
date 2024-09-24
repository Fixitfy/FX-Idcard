CREATE TABLE IF NOT EXISTS `fx_idcard` (
  `charid` varchar(50) DEFAULT NULL,
  `data` longtext DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_general_ci;

INSERT INTO `items` (`item`, `label`, `limit`, `can_remove`, `type`, `usable`, `metadata`, `desc`)
VALUES
    ('man_idcard', 'ID Card', 5, 1, 'item_standard', 1, '{}', 'Identity card with information written on it'),
    ('woman_idcard', 'ID Card', 5, 1, 'item_standard', 1, '{}', 'Identity card with information written on it'),
    ('printphoto', 'Print Photo', 10, 1, 'item_standard', 1, '{}', 'Identity photo')

ON DUPLICATE KEY UPDATE
    `item` = VALUES(`item`),
    `label` = VALUES(`label`),
    `limit` = VALUES(`limit`),
    `can_remove` = VALUES(`can_remove`),
    `type` = VALUES(`type`),
    `usable` = VALUES(`usable`),
    `metadata` = VALUES(`metadata`),
    `desc` = VALUES(`desc`);