<script setup>
import { ref, onMounted } from 'vue'
import {
  queryStuPageApi,
  addStuApi,
  queryStuByIdApi,
  updateStuApi,
  deleteStuApi,
  violationApi
} from '@/api/stu'
import { queryAllClazzApi } from '@/api/clazz'
import { ElMessage, ElMessageBox } from 'element-plus'

//学历列表数据
const degrees = ref([
  { name: '初中', value: 1 },
  { name: '高中', value: 2 },
  { name: '大专', value: 3 },
  { name: '本科', value: 4 },
  { name: '硕士', value: 5 },
  { name: '博士', value: 6 }
])
//性别列表数据
const genders = ref([
  { name: '男', value: 1 },
  { name: '女', value: 2 }
])
//是否来自院校
const colleges = ref([
  { name: '是', value: 1 },
  { name: '否', value: 0 }
])
//查询条件
const searchStu = ref({
  name: '',
  degree: '',
  clazzId: ''
})
//列表数据、分页
const stuList = ref([])
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)
//班级列表（下拉框）
const clazzList = ref([])

onMounted(() => {
  search()
  queryClazzList()
})

//查询所有班级
const queryClazzList = async () => {
  const result = await queryAllClazzApi()
  if (result.code) {
    clazzList.value = result.data
  }
}

//分页条件查询学员
const search = async () => {
  const result = await queryStuPageApi(
    searchStu.value.name,
    searchStu.value.degree,
    searchStu.value.clazzId,
    currentPage.value,
    pageSize.value
  )
  if (result.code) {
    stuList.value = result.data.rows
    total.value = result.data.total
  }
}

//清空查询条件
const clear = () => {
  searchStu.value = { name: '', degree: '', clazzId: '' }
  currentPage.value = 1
  search()
}

const handleSizeChange = () => search()
const handleCurrentChange = () => search()

//学历名称转换
const degreeName = (value) => {
  const item = degrees.value.find((d) => d.value === value)
  return item ? item.name : ''
}

//新增/修改弹窗
const dialogVisible = ref(false)
const dialogTitle = ref('新增学员')
const stuFormRef = ref(null)
//表单默认值
const defaultForm = () => ({
  name: '',
  no: '',
  gender: '',
  phone: '',
  idCard: '',
  isCollege: '',
  clazzId: '',
  degree: '',
  address: '',
  graduationDate: ''
})
const stuForm = ref(defaultForm())
//表单校验规则
const rules = ref({
  name: [{ required: true, message: '请输入姓名', trigger: 'blur' }],
  no: [{ required: true, message: '请输入学号', trigger: 'blur' }],
  gender: [{ required: true, message: '请选择性别', trigger: 'change' }],
  phone: [
    { required: true, message: '请输入手机号', trigger: 'blur' },
    { pattern: /^1[3-9]\d{9}$/, message: '请输入有效的手机号', trigger: 'blur' }
  ],
  clazzId: [{ required: true, message: '请选择班级', trigger: 'change' }],
  degree: [{ required: true, message: '请选择学历', trigger: 'change' }]
})

//新增学员
const add = () => {
  dialogTitle.value = '新增学员'
  stuForm.value = defaultForm()
  dialogVisible.value = true
  if (stuFormRef.value) {
    stuFormRef.value.resetFields()
  }
}

//重置表单
const resetForm = () => {
  if (stuFormRef.value) {
    stuFormRef.value.resetFields()
  }
}

//保存（新增/修改）
const save = async () => {
  if (!stuFormRef.value) return
  await stuFormRef.value.validate(async (valid) => {
    if (valid) {
      const result = stuForm.value.id
        ? await updateStuApi(stuForm.value)
        : await addStuApi(stuForm.value)
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

//编辑学员
const edit = async (id) => {
  const result = await queryStuByIdApi(id)
  if (result.code) {
    stuForm.value = result.data
    dialogTitle.value = '修改学员'
    dialogVisible.value = true
  } else {
    ElMessage.error(result.msg)
  }
}

//删除单个学员
const handleDelete = (id) => {
  ElMessageBox.confirm('确认删除该学员?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(async () => {
      const result = await deleteStuApi(id)
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

//记录勾选的学员id
const selectedIds = ref([])
const handleSelectionChange = (selection) => {
  selectedIds.value = selection.map((item) => item.id)
}

//批量删除
const deleteByIds = () => {
  ElMessageBox.confirm('确认删除选中的学员吗?', '提示', {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    type: 'warning'
  })
    .then(async () => {
      if (selectedIds.value && selectedIds.value.length > 0) {
        const result = await deleteStuApi(selectedIds.value)
        if (result.code) {
          ElMessage.success('删除成功')
          search()
        } else {
          ElMessage.error(result.msg)
        }
      } else {
        ElMessage.info('您没有选择任何要删除的数据')
      }
    })
    .catch(() => {
      ElMessage.info('已取消删除')
    })
}

//违纪处理
const handleViolation = (row) => {
  ElMessageBox.prompt('请输入本次违纪扣除的分数', `违纪处理 - ${row.name}`, {
    confirmButtonText: '确定',
    cancelButtonText: '取消',
    inputPattern: /^\d+$/,
    inputErrorMessage: '请输入非负整数',
    inputValue: '1'
  })
    .then(async ({ value }) => {
      const result = await violationApi(row.id, value)
      if (result.code) {
        ElMessage.success('违纪处理成功')
        search()
      } else {
        ElMessage.error(result.msg)
      }
    })
    .catch(() => { })
}
</script>

<template>
  <!-- 查询条件 -->
  <div class="container">
    <h1>学员管理</h1> <br>
    <el-form :inline="true" :model="searchStu">
      <el-form-item label="姓名">
        <el-input v-model="searchStu.name" placeholder="请输入学员姓名"></el-input>
      </el-form-item>

      <el-form-item label="学历">
        <el-select v-model="searchStu.degree" placeholder="请选择学历" clearable style="width: 120px">
          <el-option v-for="d in degrees" :key="d.value" :label="d.name" :value="d.value"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item label="班级">
        <el-select v-model="searchStu.clazzId" placeholder="请选择班级" clearable style="width: 180px">
          <el-option v-for="c in clazzList" :key="c.id" :label="c.name" :value="c.id"></el-option>
        </el-select>
      </el-form-item>

      <el-form-item>
        <el-button type="primary" @click="search">查询</el-button>
        <el-button @click="clear">清空</el-button>
      </el-form-item>
    </el-form>
  </div>

  <!-- 表格 -->
  <div class="container">
    <el-button type="primary" @click="add">+ 新增学员</el-button>
    <el-button type="danger" @click="deleteByIds">- 批量删除</el-button>
    <br /><br />
    <el-table :data="stuList" border style="width: 100%" @selection-change="handleSelectionChange">
      <el-table-column type="selection" width="50" align="center" />
      <el-table-column prop="name" label="姓名" width="90" align="center" />
      <el-table-column prop="no" label="学号" width="120" align="center" />
      <el-table-column label="性别" width="70" align="center">
        <template #default="scope">
          {{ scope.row.gender == 1 ? '男' : '女' }}
        </template>
      </el-table-column>
      <el-table-column prop="phone" label="手机号" width="130" align="center" />
      <el-table-column prop="clazzName" label="班级" min-width="150" align="center" />
      <el-table-column label="学历" width="80" align="center">
        <template #default="scope">
          {{ degreeName(scope.row.degree) }}
        </template>
      </el-table-column>
      <el-table-column prop="violationCount" label="违纪次数" width="90" align="center" />
      <el-table-column prop="violationScore" label="违纪扣分" width="90" align="center" />
      <el-table-column label="操作" fixed="right" width="240" align="center">
        <template #default="scope">
          <el-button size="small" type="warning" @click="handleViolation(scope.row)">违纪处理</el-button>
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

  <!-- 新增/修改学员对话框 -->
  <el-dialog v-model="dialogVisible" :title="dialogTitle" width="50%" @close="resetForm">
    <el-form ref="stuFormRef" :model="stuForm" :rules="rules" label-width="90px">
      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="姓名" prop="name">
            <el-input v-model="stuForm.name" placeholder="请输入学员姓名"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="学号" prop="no">
            <el-input v-model="stuForm.no" placeholder="请输入学号"></el-input>
          </el-form-item>
        </el-col>
      </el-row>

      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="性别" prop="gender">
            <el-select v-model="stuForm.gender" placeholder="请选择性别" style="width: 100%">
              <el-option v-for="g in genders" :key="g.value" :label="g.name" :value="g.value"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="手机号" prop="phone">
            <el-input v-model="stuForm.phone" placeholder="请输入手机号"></el-input>
          </el-form-item>
        </el-col>
      </el-row>

      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="班级" prop="clazzId">
            <el-select v-model="stuForm.clazzId" placeholder="请选择班级" style="width: 100%">
              <el-option v-for="c in clazzList" :key="c.id" :label="c.name" :value="c.id"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="学历" prop="degree">
            <el-select v-model="stuForm.degree" placeholder="请选择学历" style="width: 100%">
              <el-option v-for="d in degrees" :key="d.value" :label="d.name" :value="d.value"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>

      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="身份证号">
            <el-input v-model="stuForm.idCard" placeholder="请输入身份证号"></el-input>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="是否院校">
            <el-select v-model="stuForm.isCollege" placeholder="请选择" style="width: 100%">
              <el-option v-for="c in colleges" :key="c.value" :label="c.name" :value="c.value"></el-option>
            </el-select>
          </el-form-item>
        </el-col>
      </el-row>

      <el-row :gutter="20">
        <el-col :span="12">
          <el-form-item label="毕业时间">
            <el-date-picker v-model="stuForm.graduationDate" type="date" style="width: 100%" placeholder="选择毕业时间"
              format="YYYY-MM-DD" value-format="YYYY-MM-DD"></el-date-picker>
          </el-form-item>
        </el-col>
        <el-col :span="12">
          <el-form-item label="联系地址">
            <el-input v-model="stuForm.address" placeholder="请输入联系地址"></el-input>
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
