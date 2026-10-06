import axios from 'axios'
import router from '../router'
import { ElMessage, ElMessageBox } from 'element-plus'

//创建axios实例对象
const request = axios.create({
    baseURL: '/api',
    timeout: 600000
})

//axios的请求 request 拦截器, 每次请求获取localStorage中的loginUser, 从中获取到token, 在请求头token中携带到服务端
request.interceptors.request.use(
    (config) => {
        let loginUser = JSON.parse(localStorage.getItem('loginUser'))
        console.log(localStorage.getItem('loginUser'))
        if (loginUser && loginUser.token) {
            config.headers.token = loginUser.token
        }
        return config
    }
)

//axios的响应 response 拦截器
request.interceptors.response.use(
    (response) => { //成功回调
        return response.data
    },
    (error) => { //失败回调
        if (error.response.status == 401) {
            //提示错误信息
            ElMessage.error('登录已过期, 请重新登录')
            //跳转到登录页面
            router.push('/login')
        }else{
            ElMessage.error('接口访问异常')
        }
        return Promise.reject(error)
    }
)

export default request