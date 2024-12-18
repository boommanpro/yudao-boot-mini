package cn.iocoder.yudao.module.ucg.service.project;

import cn.iocoder.yudao.module.ucg.service.codetemplate.CodeTemplateService;
import org.springframework.stereotype.Service;
import javax.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.transaction.annotation.Transactional;

import java.util.*;
import java.util.function.Function;
import java.util.stream.Collectors;

import cn.iocoder.yudao.module.ucg.controller.admin.project.vo.*;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectDO;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectVariableDO;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.pojo.PageParam;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;

import cn.iocoder.yudao.module.ucg.dal.mysql.project.ProjectMapper;
import cn.iocoder.yudao.module.ucg.dal.mysql.project.ProjectVariableMapper;

import static cn.iocoder.yudao.framework.common.exception.util.ServiceExceptionUtil.exception;
import static cn.iocoder.yudao.module.ucg.enums.ErrorCodeConstants.*;

/**
 * 存储项目的基本信息 Service 实现类
 *
 * @author 管理员
 */
@Service
@Validated
public class ProjectServiceImpl implements ProjectService {

    @Resource
    private ProjectMapper projectMapper;
    @Resource
    private ProjectVariableMapper projectVariableMapper;
    @Resource
    private CodeTemplateService codeTemplateService;

    @Override
    @Transactional(rollbackFor = Exception.class)
    public Long createProject(ProjectSaveReqVO createReqVO) {
        // 插入
        ProjectDO project = BeanUtils.toBean(createReqVO, ProjectDO.class);
        projectMapper.insert(project);

        // 插入子表
        createProjectVariableList(project.getId(), createReqVO.getProjectVariables());
        // 返回
        return project.getId();
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void updateProject(ProjectSaveReqVO updateReqVO) {
        // 校验存在
        validateProjectExists(updateReqVO.getId());
        // 更新
        ProjectDO updateObj = BeanUtils.toBean(updateReqVO, ProjectDO.class);
        projectMapper.updateById(updateObj);

        // 更新子表
        updateProjectVariableList(updateReqVO.getId(), updateReqVO.getProjectVariables());
    }

    @Override
    @Transactional(rollbackFor = Exception.class)
    public void deleteProject(Long id) {
        // 校验存在
        validateProjectExists(id);
        // 删除
        projectMapper.deleteById(id);

        // 删除子表
        deleteProjectVariableByProjectId(id);
    }

    private void validateProjectExists(Long id) {
        if (projectMapper.selectById(id) == null) {
            throw exception(COMMON_EXCEPTION);
        }
    }

    @Override
    public ProjectDO getProject(Long id) {
        return projectMapper.selectById(id);
    }

    @Override
    public PageResult<ProjectDO> getProjectPage(ProjectPageReqVO pageReqVO) {
        return projectMapper.selectPage(pageReqVO);
    }

    // ==================== 子表（存储与项目相关的变量信息） ====================

    @Override
    public List<ProjectVariableDO> getProjectVariableListByProjectId(Long projectId) {
        return projectVariableMapper.selectListByProjectId(projectId);
    }

    @Override
    public Long copyProject(ProjectSaveReqVO copyReqVO) {
        ProjectDO project = BeanUtils.toBean(copyReqVO, ProjectDO.class);
        project.setId(null);
        project.clearBaseContent();
        projectMapper.insert(project);

        // 插入子表
        copyReqVO.getProjectVariables().forEach(projectVariableDO -> {
            projectVariableDO.clearBaseContent();
            projectVariableDO.setId(null);
        });
        createProjectVariableList(project.getId(), copyReqVO.getProjectVariables());
        // 返回
        codeTemplateService.copyByProject(copyReqVO.getId(), project.getId());
        return project.getId();
    }

    private void createProjectVariableList(Long projectId, List<ProjectVariableDO> list) {
        list.forEach(o -> o.setProjectId(projectId));
        projectVariableMapper.insertBatch(list);
    }

    private void updateProjectVariableList(Long projectId, List<ProjectVariableDO> list) {
        deleteProjectVariableByProjectId(projectId);
		list.forEach(o -> o.setId(null).setUpdater(null).setUpdateTime(null)); // 解决更新情况下：1）id 冲突；2）updateTime 不更新
        createProjectVariableList(projectId, list);
    }

    private void deleteProjectVariableByProjectId(Long projectId) {
        projectVariableMapper.deleteByProjectId(projectId);
    }

}
