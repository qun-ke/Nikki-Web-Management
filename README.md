# Nikki‑Web‑Management 教学管理后台系统

## 📖 项目介绍
本项目是一套教学机构后台管理系统，后端基于 SpringBoot + MyBatis 开发，前端使用 Vue3 + Element‑Plus 实现。
实现登录认证、部门管理、员工管理、班级管理、学员管理、数据图表统计、操作日志记录完整业务功能。

### ✨ 主要功能
1. **登录认证模块**
- JWT令牌登录校验，SpringMVC拦截器统一拦截未登录请求
- 登录、退出登录，ThreadLocal传递登录用户ID

2. **基础业务模块**
- 部门管理：部门列表查询、新增、修改、删除（删除前校验部门下是否存在员工）
- 员工管理：员工分页条件查询、新增、修改、删除、批量删除，查询全部员工（下拉选择班主任）
- 班级管理：班级条件分页查询、新增、修改、删除，班级状态自动计算，下拉回显班主任
- 学员管理：学员条件分页查询、新增、修改、删除、批量删除，学员违纪扣分处理

3. **数据统计模块**
- 员工统计：员工性别饼图、员工职位柱状图
- 学员统计：学员学历环形饼图、班级人数柱状图

4. **日志模块**
- AOP环绕通知自动记录操作日志，保存操作人、类名、方法名、参数、返回值、执行耗时
- 日志分页查询页面展示操作记录

## 🛠 技术栈
### 后端
- SpringBoot 框架
- MyBatis 持久层框架
- JWT：令牌生成与解析
- AOP：切面实现操作日志
- ThreadLocal：请求线程内传递登录用户ID
- PageHelper：分页插件
- Lombok：简化实体类代码

### 前端
- Vue3 + Vite
- Element‑Plus UI组件库
- Axios 网络请求
- ECharts 图表可视化
- Vue‑Router 路由 + 全局路由守卫（未登录强制跳转登录页）

## 📂 项目目录说明
> 单仓库结构
Nikki‑Web‑Management
├── backend                 # SpringBoot 后端
│   ├── src/main/java       # Java 源代码
│   ├── src/main/resources  # mapper 映射文件、配置文件
│   ├── sql                 # 数据库建表脚本
│   └── pom.xml             # maven 依赖
├── frontend                # Vue 前端
│   ├── src
│   │   ├── api             # 接口请求封装
│   │   ├── views           # 页面组件
│   │   ├── router          # 路由配置（含全局守卫）
│   │   └── main.js
│   ├── public
│   ├── vite.config.js
│   └── package.json
└── README.md

## 🚀 本地运行步骤

### 1. 后端启动
1. 使用提供的sql脚本，在MySQL执行，创建数据库和数据表，导入测试数据。
2. 修改配置文件：复制 `application-example.yml` 重命名为 `application.yml`
3. 修改yml中数据库连接地址、账号密码、JWT密钥。
4. 运行 SpringBoot 主启动类，后端默认端口：`8081`

> 注意：不要直接上传带有真实密码的application.yml到Github。

### 2. 前端启动
```bash
# 进入前端项目文件夹
cd frontend

# 安装依赖
npm install

# 本地开发运行
npm run dev
