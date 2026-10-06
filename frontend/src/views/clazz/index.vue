<script setup>
import { ref, watch, onMounted } from 'vue'
import {
  queryClazzPageApi,
  addClazzApi,
  queryClazzByIdApi,
  updateClazzApi,
  deleteClazzApi
} from '@/api/clazz'
import { queryAllEmpApi } from '@/api/emp'
import { ElMessage, ElMessageBox } from 'element-plus'

//学科列表数据
const subjects = ref([
  { name: 'Java', value: 1 },
  { name: '前端', value: 2 },
  { name: '大数据', value: 3 },
  { name: 'Python', value: 4 },
  { name: 'Go', value: 5 },
  { name: '嵌入式', value: 6 }
])
//查询条件
const searchClazz = ref({
  name: '',
  date: [],
  begin: '',
  end: ''
})
//列表数据、分页
const clazzList = ref([])
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
//班主任（员工）列表
const empList = ref([])

onMounted(() => {
  search()
  queryEmpList()
})

//查询所有员工（班主任下拉）
const queryEmpList = async () => {
  const result = await queryAllEmpApi()
  if (result.code) {
    empList.value = result.data
  }
}

//分页条件查询班级
const search = async () => {
  const result = await queryClazzPageApi(
    searchClazz.value.name,
    searchClazz.value.begin,
    searchClazz.value.end,
    currentPage.value,
    pageSize.value
  )
  if (result.code) {
    clazzList.value = result.data.rows
    total.value = result.data.total
  }
}

//侦听结课时间范围
watch(
  () => searchClazz.value.date,
  (newValue) => {
    if (newValue && newValue.length === 2) {
      searchClazz.value.begin = newValue[0]
      searchClazz.value.end = newValue[1]
    } else {
      searchClazz.value.begin = ''
      searchClazz.value.end = ''
    }
  }
)

//清空查询条件
const clear = () => {
  searchClazz.value = { name: '', date: [], begin: '', end: '' }
  currentPage.value = 1
  search()
}

const handleSizeChange = () => search()
const handleCurrentChange = () => search()

//学科名称转换
const subjectName = (value) => {
  const item = subjects.value.find((s) => s.value === value)
  return item ? item.name : ''
}
//班级状态标签颜色
const statusType = (status) => {
  if (status === '已开班') return 'success'
  if (status === '已结课') return 'info'
  return 'warning'
}

//新增/修改弹窗
const dialogVisible = ref(false)
const dialogTitle = ref('新增班级')
const clazzFormRef = ref(null)
const clazzForm = ref({
  name: '',
  room: '',
  beginDate: '',
  endDate: '',
  masterId: '',
  subject: ''
})
//表单校验规则
const rules = ref({
  name: [{ required: true, message: '请输入班级名称', trigger: 'blur' }],
  room: [{ required: true, message: '请输入班级教室', trigger: 'blur' }],
  beginDate: [{ required: true, message: '请选择开课时间', trigger: 'change' }],
  endDate: [{ required: true, message: '请选择结课时间', trigger: 'change' }],
  subject: [{ required: true, message: '请选择学科', trigger: 'change' }]
})

//新增班级
const add = () => {
  dialogTitle.value = '新增班级'
  clazzForm.value = { name: '', room: '', beginDate: '', endDate: '', masterId: '', subject: '' }
  dialogVisible.value = true
  if (clazzFormRef.value) {
    clazzFormRef.value.resetFields()
  }
}

//重置表单
const resetForm = () => {
  if (clazzFormRef.value) {
    clazzFormRef.value.resetFields()
  }
}

//保存（新增/修改）
const save = async () => {
  if (!clazzFormRef.value) return
  await clazzFormRef.value.validate(async (valid) => {
    if (valid) {
      const result = clazzForm.value.id
        ? await updateClazzApi(clazzForm.value)
        : await addClazzApi(clazzForm.value)
      if (result.code) {
        ElMessage.success('操作成功')
        dialogVisible.value = false
        search()
      } else {
        ElMessage.error(result.msg)
      }
    } else {
      ElMessage.error('表单校验失败')
    }
  })
}

//编辑班级
const edit = async (id) => {
  const result = await queryClazzByIdApi(id)
  if (result.code) {
    clazzForm.value = result.data
    dialogTitle.value = '修改班级'
    dialogVisible.value = true
  } else {
    ElMessage.error(result.msg)
  }
}

//删除班级
const handleDelete = (id) => {
  ElMessageBox.confirm('确认删除该班级?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(async () => {
      const result = await deleteClazzApi(id)
      if (result.code) {
        ElMessage.success('删除成功')
        search()
      } else {
        ElMessage.error(result.msg)
      }
    })
    .catch(() => {
      ElMessage.info('已取消删除')
    })
}
</script>

<template>
  <!-- 查询条件 -->
  <div class="container">
    <h1>班级管理</h1> <br>
    <el-form :inline="true" :model="searchClazz">
      <el-form-item label="班级名称">
        <el-input v-model="searchClazz.name" placeholder="请输入班级名称"></el-input>
      </el-form-item>

      <el-form-item label="结课时间">
        <el-date-picker v-model="searchClazz.date" type="daterange" range-separator="至" start-placeholder="开始日期"
          end-placeholder="结束日期" value-format="YYYY-MM-DD"></el-date-picker>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="search">查询</el-button>
        <el-button @click="clear">清空</el-button>
      </el-form-item>
    </el-form>
  </div>

  <!-- 表格 -->
  <div class="container">
    <el-button type="primary" @click="add">+ 新增班级</el-button>
    <br /><br />
    <el-table :data="clazzList" border style="width: 100%">
      <el-table-column type="index" label="序号" width="70" align="center" />
      <el-table-column prop="name" label="班级名称" min-width="160" align="center" />
      <el-table-column prop="room" label="班级教室" width="100" align="center" />
      <el-table-column prop="masterName" label="班主任" width="110" align="center" />
      <el-table-column label="学科" width="100" align="center">
        <template #default="scope">
          {{ subjectName(scope.row.subject) }}
        </template>
      </el-table-column>
      <el-table-column prop="beginDate" label="开课时间" width="120" align="center" />
      <el-table-column prop="endDate" label="结课时间" width="120" align="center" />
      <el-table-column label="状态" width="100" align="center">
        <template #default="scope">
          <el-tag :type="statusType(scope.row.status)">{{ scope.row.status }}</el-tag>
        </template>
      </el-table-column>
      <el-table-column prop="updateTime" label="最后操作时间" width="180" align="center" />
      <el-table-column label="操作" fixed="right" width="160" align="center">
        <template #default="scope">
          <el-button size="small" type="primary" @click="edit(scope.row.id)">编辑</el-button>
          <el-button size="small" type="danger" @click="handleDelete(scope.row.id)">删除</el-button>
        </template>
      </el-table-column>
    </el-table>
  </div>

  <!-- 分页 -->
  <div class="container">
    <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
      v-model:current-page="currentPage" v-model:page-size="pageSize" :page-sizes="[5, 10, 20, 30, 40]"
      layout="total, sizes, prev, pager, next, jumper" :total="total">
    </el-pagination>
  </div>

  <!-- 新增/修改班级对话框 -->
  <el-dialog v-model="dialogVisible" :title="dialogTitle" width="50%" @close="resetForm">
    <el-form ref="clazzFormRef" :model="clazzForm" :rules="rules" label-width="90px">
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="班级名称" prop="name">
            <el-input v-model="clazzForm.name" placeholder="请输入班级名称"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="班级教室" prop="room">
            <el-input v-model="clazzForm.room" placeholder="请输入班级教室"></el-input>
          </el-form-item>
        </el-col>
      </el-row>

      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="班主任">
            <el-select v-model="clazzForm.masterId" placeholder="请选择班主任" style="width: 100%" clearable>
              <el-option v-for="emp in empList" :key="emp.id" :label="emp.name" :value="emp.id"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="学科" prop="subject">
            <el-select v-model="clazzForm.subject" placeholder="请选择学科" style="width: 100%">
              <el-option v-for="s in subjects" :key="s.value" :label="s.name" :value="s.value"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>

      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="开课时间" prop="beginDate">
            <el-date-picker v-model="clazzForm.beginDate" type="date" style="width: 100%" placeholder="选择开课时间"
              format="YYYY-MM-DD" value-format="YYYY-MM-DD"></el-date-picker>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="结课时间" prop="endDate">
            <el-date-picker v-model="clazzForm.endDate" type="date" style="width: 100%" placeholder="选择结课时间"
              format="YYYY-MM-DD" value-format="YYYY-MM-DD"></el-date-picker>
          </el-form-item>
        </el-col>
      </el-row>
    </el-form>

    <template #footer>
      <span class="dialog-footer">
        <el-button @click="dialogVisible = false">取消</el-button>
        <el-button type="primary" @click="save">确定</el-button>
      </span>
    </template>
  </el-dialog>
</template>

<style scoped>
.container {
  margin: 15px 0px;
}
</style>
