package cn.iocoder.yudao.module.infra.service.codegen.inner;



import org.springframework.beans.BeansException;
import org.springframework.context.ApplicationContext;
import org.springframework.context.ApplicationContextException;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.expression.*;
import org.springframework.context.support.GenericApplicationContext;
import org.springframework.expression.Expression;
import org.springframework.expression.ParserContext;
import org.springframework.expression.spel.standard.SpelExpressionParser;
import org.springframework.expression.spel.support.StandardEvaluationContext;
import org.springframework.expression.spel.support.StandardTypeLocator;

import java.lang.reflect.Method;
import java.util.Map;
import java.util.concurrent.ConcurrentHashMap;

public class SpringExpressionParser  {

    private static final long serialVersionUID = 1L;

    private StandardEvaluationContext context;

    private VueStyleParserContext vueStyleParserContext = new VueStyleParserContext();

    private org.springframework.expression.ExpressionParser expressionParser;

    private final ConcurrentHashMap<String, Expression> EXPRESSION_MAP = new ConcurrentHashMap<>();

    private final ConcurrentHashMap<String, Expression> TEMPLATE_MAP = new ConcurrentHashMap<>();

    public <T> T getValue(String expressionString) {
        return getValue(expressionString, null);
    }

    private static final SpringExpressionParser PARSER = new SpringExpressionParser();

    public static SpringExpressionParser getInstance() {
        return PARSER;
    }

    private SpringExpressionParser() {
        setApplicationContext(new GenericApplicationContext());
    }


    public String getTemplateValue(String expressionString, Map<String, Object> rootObject) {
        return getTemplateExpression(expressionString).getValue(context, rootObject, String.class);
    }


    @SuppressWarnings("all")
    public <T> T getValue(String expressionString, Map<String, Object> rootObject) {
        Expression expression = getExpression(expressionString);
        return ((T) expression.getValue(context, rootObject));
    }

    private Expression getTemplateExpression(String expressionString) {
        return TEMPLATE_MAP.computeIfAbsent(expressionString, s -> expressionParser.parseExpression(s, vueStyleParserContext));
    }


    public static class VueStyleParserContext implements ParserContext {
        @Override
        public boolean isTemplate() {
            return true;
        }

        @Override
        public String getExpressionPrefix() {
            return "${";
        }

        @Override
        public String getExpressionSuffix() {
            return "}";
        }
    }


    private Expression getExpression(String expressionString) {
        return EXPRESSION_MAP.computeIfAbsent(expressionString, s -> expressionParser.parseExpression(s));
    }


    @SuppressWarnings("all")
    public void setApplicationContext(ApplicationContext applicationContext) throws BeansException {
        if (applicationContext instanceof ConfigurableApplicationContext) {
            ConfigurableApplicationContext ac = (ConfigurableApplicationContext) applicationContext;
            context = new StandardEvaluationContext();
            context.addPropertyAccessor(new BeanExpressionContextAccessor());
            context.addPropertyAccessor(new BeanFactoryAccessor());
            context.addPropertyAccessor(new MapAccessor());
            context.addPropertyAccessor(new EnvironmentAccessor());
            context.setBeanResolver(new BeanFactoryResolver(ac.getBeanFactory()));
            context.setTypeLocator(new StandardTypeLocator(ac.getBeanFactory().getBeanClassLoader()));
            //初始化上下文
            expressionParser = new SpelExpressionParser();
            //注册默认工具方法
//            registerFunc(context,ExtraUtils.class);
        } else {
            throw new ApplicationContextException("can't cast ConfigurableApplicationContext");
        }
    }

    public void registerFunc(StandardEvaluationContext context, Class clazz) {
        Method[] methods = clazz.getDeclaredMethods();
        for (Method method : methods) {
            if (method.getModifiers() == 9) {
                String name = method.getName();
                context.registerFunction(name, method);
            }
        }
    }

    public void registerFunc(StandardEvaluationContext context, String className) throws ClassNotFoundException {
        Class<?> clazz = Class.forName(className);
        Method[] methods = clazz.getDeclaredMethods();
        for (Method method : methods) {
            if (method.getModifiers() == 9) {
                String name = method.getName();
                context.registerFunction(name, method);
            }
        }
    }
}
