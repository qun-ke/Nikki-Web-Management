<script setup>
import { ref ,onMounted} from 'vue'
import {queryAllApi, addDeptApi, queryDeptByIdApi, updateDeptApi, deleteDeptApi } from '@/api/dept'
import { ElMessage, ElMessageBox } from 'element-plus'
//声明列表展示数据
let deptList = ref([])

//动态加载数据-查询部门
const queryAll = async () => {
  const result = await queryAllApi()
  if(result.code){
    deptList.value = result.data
  }
}

//钩子函数
onMounted(() => {
  queryAll()
})

const formTitle = ref('')
//新增部门
const add = () => {
  formTitle.value = '新增部门'
  showDialog.value = true
  deptForm.value = { name: '' }
}
// 新增部门对话框的状态
const showDialog = ref(false)
// 表单数据
const deptForm = ref({ name: '' })
// 表单验证规则
const formRules = ref({
  name: [
    { required: true, message: '请输入部门名称', trigger: 'blur' },
    { min: 2, max: 10, message: '长度在 2 到 10 个字符', trigger: 'blur' }
  ]
})
// 表单引用
const deptFormRef = ref(null)
// 重置表单
const resetForm = () => {
  deptFormRef.value.resetFields()
}
// 提交表单
const save = async () => {
  if(!deptFormRef.value) return;
  await deptFormRef.value.validate(async valid => {
    if (valid) {
      //校验成功，调用后端新增部门接口
      let result
      if (deptForm.value.id) { 
         result = await updateDeptApi(deptForm.value)
      }else{
         result = await addDeptApi(deptForm.value)
      }
      if (result.code) {
        ElMessage.success('操作成功')
        showDialog.value = false //关闭弹窗
        resetForm() //重置表单
        queryAll() //重新加载表格数据（刷新列表）
      } else {
        ElMessage.error(result.msg)
      }
    } else {
      ElMessage.error('表单校验失败')
    }
  })
}
// 编辑部门
const handleEdit = async (id) => {
  formTitle.value = '编辑部门'
  const result = await queryDeptByIdApi(id)
  if (result.code) {
    showDialog.value = true
    deptForm.value = result.data
    queryAll()
  } else {
    ElMessage.error(result.msg)
  }
}

// 删除部门 - 根据ID删除部门
const handleDelete = (id) => {
    ElMessageBox.confirm('确认删除该部门?', '提示', {
      confirmButtonText: '确定',cancelButtonText: '取消',type: 'warning',
    }).then(async () => {
      //调用后端接口
      const result = await deleteDeptApi(id)
      if (result.code) {
        ElMessage.success('删除成功')
        queryAll() //重新加载表格数据（刷新列表）
      }else {
        ElMessage.error(result.msg)
      }
    }).catch(()=>{
      ElMessage.info('已取消删除')
    })
};
</script>

<template>
  <h1>部门管理</h1>
  <div class="container"><el-button type="primary" @click="add">+ 新增部门</el-button></div>
  <div class="container">
    <el-table :data="deptList" border style="width: 100%;">
      <el-table-column type="index" label="序号" width="100" align="center" />
      <el-table-column prop="name" label="部门名称" width="300" align="center" />
      <el-table-column prop="updateTime" label="最后修改时间" width="300" align="center" />
      <el-table-column fixed="right" label="操作" align="center">
        <template #default="scope">
          <el-button size="small" type="primary" @click="handleEdit(scope.row.id)">编辑</el-button>
          <el-button size="small" type="danger" @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>

  <!-- 新增部门的对话框 -->
  <el-dialog v-model="showDialog" :title="formTitle" width="30%" @close="resetForm">
    <el-form :model="deptForm" :rules="formRules" ref="deptFormRef">
      <el-form-item label="部门名称" prop="name" label-width="80px">
        <el-input v-model="deptForm.name" autocomplete="off"></el-input>
      </el-form-item>
    </el-form>
    <template #footer>
      <span class="dialog-footer">
        <el-button @click="showDialog = false">取消</el-button>
        <el-button type="primary" @click="save">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<style scoped>
.container {
  margin: 10px 0px;
}
</style>
