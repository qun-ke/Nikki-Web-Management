import { createRouter, createWebHistory } from 'vue-router'
import IndexView from '@/views/index/index.vue';
import ClazzView from '@/views/clazz/index.vue';
import StuView from '@/views/stu/index.vue';
import DeptView from '@/views/dept/index.vue';
import EmpView from '@/views/emp/index.vue';
import EmpReportView from '@/views/report/emp/index.vue';
import StuReportView from '@/views/report/stu/index.vue';
import LogView from '@/views/log/index.vue';
import LoginView from '@/views/login/index.vue';
import LayoutView from '@/views/layout/index.vue';

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    {
      path: '/',
      name: '',
      component: LayoutView,
      redirect: '/index', //重定向
      children: [
        { path: 'index', name: 'index', component: IndexView },
        { path: 'clazz', name: 'clazz', component: ClazzView },
        { path: 'stu', name: 'stu', component: StuView },
        { path: 'dept', name: 'dept', component: DeptView },
        { path: 'emp', name: 'emp', component: EmpView },
        { path: 'log', name: 'log', component: LogView },
        { path: 'empReport', name: 'empReport', component: EmpReportView },
        { path: 'stuReport', name: 'stuReport', component: StuReportView },
      ]
    },
    { path: '/login', component: LoginView },
  ]
})

// 全局前置路由守卫
// router.beforeEach((to, from, next) => {
//   // 从localStorage取出token
//   const token = localStorage.getItem('token')
//   // 如果要去登录页，直接放行
//   if (to.path === '/login') {
//     next()
//   } else {
//     // 访问其他页面，判断是否有token
//     if (token) {
//       next() // 有token，放行，进入首页
//     } else {
//       next('/login') // 无token，强制跳登录页
//     }
//   }
// })

export default router
