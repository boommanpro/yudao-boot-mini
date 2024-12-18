package cn.iocoder.yudao.module.ucg.controller.admin.project;

import org.springframework.web.bind.annotation.*;
import javax.annotation.Resource;
import org.springframework.validation.annotation.Validated;
import org.springframework.security.access.prepost.PreAuthorize;
import io.swagger.v3.oas.annotations.tags.Tag;
import io.swagger.v3.oas.annotations.Parameter;
import io.swagger.v3.oas.annotations.Operation;

import javax.validation.constraints.*;
import javax.validation.*;
import javax.servlet.http.*;
import java.util.*;
import java.io.IOException;

import cn.iocoder.yudao.framework.common.pojo.PageParam;
import cn.iocoder.yudao.framework.common.pojo.PageResult;
import cn.iocoder.yudao.framework.common.pojo.CommonResult;
import cn.iocoder.yudao.framework.common.util.object.BeanUtils;
import static cn.iocoder.yudao.framework.common.pojo.CommonResult.success;

import cn.iocoder.yudao.framework.excel.core.util.ExcelUtils;

import cn.iocoder.yudao.framework.apilog.core.annotation.ApiAccessLog;
import static cn.iocoder.yudao.framework.apilog.core.enums.OperateTypeEnum.*;

import cn.iocoder.yudao.module.ucg.controller.admin.project.vo.*;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectDO;
import cn.iocoder.yudao.module.ucg.dal.dataobject.project.ProjectVariableDO;
import cn.iocoder.yudao.module.ucg.service.project.ProjectService;

@Tag(name = "管理后台 - 存储项目的基本信息")
@RestController
@RequestMapping("/ucg/project")
@Validated
public class ProjectController {

    @Resource
    private ProjectService projectService;

    @PostMapping("/create")
    @Operation(summary = "创建存储项目的基本信息")
    @PreAuthorize("@ss.hasPermission('ucg:project:create')")
    public CommonResult<Long> createProject(@Valid @RequestBody ProjectSaveReqVO createReqVO) {
        return success(projectService.createProject(createReqVO));
    }

    @PutMapping("/update")
    @Operation(summary = "更新存储项目的基本信息")
    @PreAuthorize("@ss.hasPermission('ucg:project:update')")
    public CommonResult<Boolean> updateProject(@Valid @RequestBody ProjectSaveReqVO updateReqVO) {
        projectService.updateProject(updateReqVO);
        return success(true);
    }

    @PostMapping("/copy")
    @Operation(summary = "复制存储项目的基本信息")
    @PreAuthorize("@ss.hasPermission('ucg:project:create')")
    public CommonResult<Long> copyProject(@Valid @RequestBody ProjectSaveReqVO copyReqVO) {
        return success(projectService.copyProject(copyReqVO));
    }

    @DeleteMapping("/delete")
    @Operation(summary = "删除存储项目的基本信息")
    @Parameter(name = "id", description = "编号", required = true)
    @PreAuthorize("@ss.hasPermission('ucg:project:delete')")
    public CommonResult<Boolean> deleteProject(@RequestParam("id") Long id) {
        projectService.deleteProject(id);
        return success(true);
    }

    @GetMapping("/get")
    @Operation(summary = "获得存储项目的基本信息")
    @Parameter(name = "id", description = "编号", required = true, example = "1024")
    @PreAuthorize("@ss.hasPermission('ucg:project:query')")
    public CommonResult<ProjectRespVO> getProject(@RequestParam("id") Long id) {
        ProjectDO project = projectService.getProject(id);
        return success(BeanUtils.toBean(project, ProjectRespVO.class));
    }

    @GetMapping("/page")
    @Operation(summary = "获得存储项目的基本信息分页")
    @PreAuthorize("@ss.hasPermission('ucg:project:query')")
    public CommonResult<PageResult<ProjectRespVO>> getProjectPage(@Valid ProjectPageReqVO pageReqVO) {
        PageResult<ProjectDO> pageResult = projectService.getProjectPage(pageReqVO);
        return success(BeanUtils.toBean(pageResult, ProjectRespVO.class));
    }

    @GetMapping("/export-excel")
    @Operation(summary = "导出存储项目的基本信息 Excel")
    @PreAuthorize("@ss.hasPermission('ucg:project:export')")
    @ApiAccessLog(operateType = EXPORT)
    public void exportProjectExcel(@Valid ProjectPageReqVO pageReqVO,
              HttpServletResponse response) throws IOException {
        pageReqVO.setPageSize(PageParam.PAGE_SIZE_NONE);
        List<ProjectDO> list = projectService.getProjectPage(pageReqVO).getList();
        // 导出 Excel
        ExcelUtils.write(response, "存储项目的基本信息.xls", "数据", ProjectRespVO.class,
                        BeanUtils.toBean(list, ProjectRespVO.class));
    }

    // ==================== 子表（存储与项目相关的变量信息） ====================

    @GetMapping("/project-variable/list-by-project-id")
    @Operation(summary = "获得存储与项目相关的变量信息列表")
    @Parameter(name = "projectId", description = "工厂ID，与`ucg_project`表的`id`相关联，标识所属项目")
    @PreAuthorize("@ss.hasPermission('ucg:project:query')")
    public CommonResult<List<ProjectVariableDO>> getProjectVariableListByProjectId(@RequestParam("projectId") Long projectId) {
        return success(projectService.getProjectVariableListByProjectId(projectId));
    }

}
