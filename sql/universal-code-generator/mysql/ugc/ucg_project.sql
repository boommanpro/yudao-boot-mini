create table ucg_project
(
    id                  bigint auto_increment comment '编号，自增，唯一标识一个项目'
        primary key,
    project_name        varchar(128)                                                     not null comment '项目名称，不能为空',
    project_description text                                                             null comment '项目描述，文本类型，可以为空',
    enable_status       bit                                    default b'1'              not null comment '启动状态',
    creator             varchar(64) collate utf8mb4_unicode_ci default ''                null comment '创建者，默认为空字符串',
    create_time         datetime                               default CURRENT_TIMESTAMP not null comment '创建时间，默认为当前时间戳',
    updater             varchar(64) collate utf8mb4_unicode_ci default ''                null comment '更新者，默认为空字符串',
    update_time         datetime                               default CURRENT_TIMESTAMP not null on update CURRENT_TIMESTAMP comment '更新时间，默认为当前时间戳，更新记录时自动更新',
    deleted             bit                                    default b'0'              not null comment '是否删除，位类型，默认为0（未删除）'
)
    comment '存储项目的基本信息';

INSERT INTO `ruoyi-vue-pro`.ucg_project (id, project_name, project_description, enable_status, creator, create_time, updater, update_time, deleted) VALUES (1, 'yudao-ui-admin-vue3', 'yudao默认自带样式', false, '1', '2024-12-15 08:16:30', '1', '2024-12-17 23:42:15', false);
INSERT INTO `ruoyi-vue-pro`.ucg_project (id, project_name, project_description, enable_status, creator, create_time, updater, update_time, deleted) VALUES (2, 'yudao-ui-admin-vue2', 'yudao默认自带样式', true, '1', '2024-12-17 21:46:57', '1', '2024-12-17 21:47:20', true);
INSERT INTO `ruoyi-vue-pro`.ucg_project (id, project_name, project_description, enable_status, creator, create_time, updater, update_time, deleted) VALUES (3, 'yudao-ui-admin-vue2', 'yudao默认自带样式', true, '1', '2024-12-17 21:48:50', '1', '2024-12-17 23:42:19', false);
