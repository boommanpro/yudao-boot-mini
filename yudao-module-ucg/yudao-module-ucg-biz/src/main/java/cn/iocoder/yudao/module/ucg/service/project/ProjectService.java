package cn.iocoder.yudao.module.ucg.service.project;

import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.module.ucg.controller.admin.project.vo.ProjectPageReqVO;
import cn.iocoder.yudao.module.ucg.controller.admin.project.vo.ProjectSaveReqVO;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectDO;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectVariableDO;

import javax.validation.Valid;
import java.util.List;

/**
 * 存储项目的基本信息 Service 接口
 *
 * @author 管理员
 */
public interface ProjectService {

    /**
     * 创建存储项目的基本信息
     *
     * @param createReqVO 创建信息
     * @return 编号
     */
    Long createProject(@Valid ProjectSaveReqVO createReqVO);

    /**
     * 更新存储项目的基本信息
     *
     * @param updateReqVO 更新信息
     */
    void updateProject(@Valid ProjectSaveReqVO updateReqVO);

    /**
     * 删除存储项目的基本信息
     *
     * @param id 编号
     */
    void deleteProject(Long id);

    /**
     * 获得存储项目的基本信息
     *
     * @param id 编号
     * @return 存储项目的基本信息
     */
    ProjectDO getProject(Long id);

    /**
     * 获得存储项目的基本信息分页
     *
     * @param pageReqVO 分页查询
     * @return 存储项目的基本信息分页
     */
    PageResult<ProjectDO> getProjectPage(ProjectPageReqVO pageReqVO);

    // ==================== 子表（存储与项目相关的变量信息） ====================

    /**
     * 获得存储与项目相关的变量信息列表
     *
     * @param projectId 工厂ID，与`ucg_project`表的`id`相关联，标识所属项目
     * @return 存储与项目相关的变量信息列表
     */
    List<ProjectVariableDO> getProjectVariableListByProjectId(Long projectId);

    Long copyProject(ProjectSaveReqVO copyReqVO);
}
