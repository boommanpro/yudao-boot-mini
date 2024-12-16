package cn.iocoder.yudao.module.infra.service.codegen.inner;

public class SpringElFunction {

    public static String convertFilePath(String packagePath) {
        return packagePath.replaceAll("\\.", "/");
    }
}
