<script setup>
import { ref, onMounted } from 'vue'
import { logPageApi } from '@/api/log'
import { ElMessage } from 'element-plus'

//列表数据、分页
const logList = ref([])
const currentPage = ref(1)
const pageSize = ref(10)
const total = ref(0)

onMounted(() => {
  search()
})

//分页查询操作日志
const search = async () => {
  const result = await logPageApi(currentPage.value, pageSize.value)
  if (result.code) {
    logList.value = result.data.rows
    total.value = result.data.total
  } else {
    ElMessage.error(result.msg)
  }
}

const handleSizeChange = () => search()
const handleCurrentChange = () => search()
</script>

<template>
  <div>
    <h1>日志信息统计</h1>
    <div class="container">
      <el-table :data="logList" border style="width: 100%">
        <el-table-column type="index" label="序号" width="70" align="center" />
        <el-table-column prop="operateEmpName" label="操作人" width="100" align="center" />
        <el-table-column prop="operateTime" label="操作时间" width="180" align="center" />
        <el-table-column prop="className" label="操作类名" min-width="260" align="center" show-overflow-tooltip />
        <el-table-column prop="methodName" label="方法名" width="130" align="center" />
        <el-table-column prop="methodParams" label="方法参数" min-width="220" show-overflow-tooltip />
        <el-table-column prop="returnValue" label="返回值" min-width="200" show-overflow-tooltip />
        <el-table-column label="耗时(ms)" width="100" align="center">
          <template #default="scope">
            <el-tag :type="scope.row.costTime > 100 ? 'danger' : 'success'">
              {{ scope.row.costTime }}
            </el-tag>
          </template>
        </el-table-column>
      </el-table>
    </div>

    <!-- 分页 -->
    <div class="container">
      <el-pagination @size-change="handleSizeChange" @current-change="handleCurrentChange"
        v-model:current-page="currentPage" v-model:page-size="pageSize" :page-sizes="[10, 20, 30, 40, 50]"
        layout="total, sizes, prev, pager, next, jumper" :total="total">
      </el-pagination>
    </div>
  </div>
</template>

<style scoped>
.container {
  margin: 15px 0px;
}
</style>
