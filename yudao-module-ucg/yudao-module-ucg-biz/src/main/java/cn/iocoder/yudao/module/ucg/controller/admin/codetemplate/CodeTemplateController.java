package cn.iocoder.yudao.module.ucg.controller.admin.codetemplate;

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

import cn.iocoder.yudao.module.ucg.controller.admin.codetemplate.vo.*;
import cn.iocoder.yudao.module.ucg.dal.dataobject.codetemplate.CodeTemplateDO;
import cn.iocoder.yudao.module.ucg.service.codetemplate.CodeTemplateService;

@Tag(name = "管理后台 - 存储代码模板的基本信息")
@RestController
@RequestMapping("/ucg/code-template")
@Validated
public class CodeTemplateController {

    @Resource
    private CodeTemplateService codeTemplateService;

    @PostMapping("/create")
    @Operation(summary = "创建存储代码模板的基本信息")
    @PreAuthorize("@ss.hasPermission('ucg:code-template:create')")
    public CommonResult<Long> createCodeTemplate(@Valid @RequestBody CodeTemplateSaveReqVO createReqVO) {
        return success(codeTemplateService.createCodeTemplate(createReqVO));
    }

    @PutMapping("/update")
    @Operation(summary = "更新存储代码模板的基本信息")
    @PreAuthorize("@ss.hasPermission('ucg:code-template:update')")
    public CommonResult<Boolean> updateCodeTemplate(@Valid @RequestBody CodeTemplateSaveReqVO updateReqVO) {
        codeTemplateService.updateCodeTemplate(updateReqVO);
        return success(true);
    }

    @DeleteMapping("/delete")
    @Operation(summary = "删除存储代码模板的基本信息")
    @Parameter(name = "id", description = "编号", required = true)
    @PreAuthorize("@ss.hasPermission('ucg:code-template:delete')")
    public CommonResult<Boolean> deleteCodeTemplate(@RequestParam("id") Long id) {
        codeTemplateService.deleteCodeTemplate(id);
        return success(true);
    }

    @GetMapping("/get")
    @Operation(summary = "获得存储代码模板的基本信息")
    @Parameter(name = "id", description = "编号", required = true, example = "1024")
    @PreAuthorize("@ss.hasPermission('ucg:code-template:query')")
    public CommonResult<CodeTemplateRespVO> getCodeTemplate(@RequestParam("id") Long id) {
        CodeTemplateDO codeTemplate = codeTemplateService.getCodeTemplate(id);
        return success(BeanUtils.toBean(codeTemplate, CodeTemplateRespVO.class));
    }

    @GetMapping("/page")
    @Operation(summary = "获得存储代码模板的基本信息分页")
    @PreAuthorize("@ss.hasPermission('ucg:code-template:query')")
    public CommonResult<PageResult<CodeTemplateRespVO>> getCodeTemplatePage(@Valid CodeTemplatePageReqVO pageReqVO) {
        PageResult<CodeTemplateDO> pageResult = codeTemplateService.getCodeTemplatePage(pageReqVO);
        return success(BeanUtils.toBean(pageResult, CodeTemplateRespVO.class));
    }

    @GetMapping("/export-excel")
    @Operation(summary = "导出存储代码模板的基本信息 Excel")
    @PreAuthorize("@ss.hasPermission('ucg:code-template:export')")
    @ApiAccessLog(operateType = EXPORT)
    public void exportCodeTemplateExcel(@Valid CodeTemplatePageReqVO pageReqVO,
              HttpServletResponse response) throws IOException {
        pageReqVO.setPageSize(PageParam.PAGE_SIZE_NONE);
        List<CodeTemplateDO> list = codeTemplateService.getCodeTemplatePage(pageReqVO).getList();
        // 导出 Excel
        ExcelUtils.write(response, "存储代码模板的基本信息.xls", "数据", CodeTemplateRespVO.class,
                        BeanUtils.toBean(list, CodeTemplateRespVO.class));
    }

}