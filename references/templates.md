---
name: easy-wiki/templates
description: >
  AGENTS.md 模板和页面模板。在翻译阶段 Read 本文件，
  根据访谈结果选择对应模板并填充用户特定内容。
---

# 模板库

## 目录

- [场景一 AGENTS.md 模板](#场景一-agentsmd-模板)
- [场景二 AGENTS.md 模板](#场景二-agentsmd-模板)
- [页面模板](#页面模板)
  - [概念/规则页](#概念规则页模板)
  - [案例页](#案例页模板)
  - [信源摘要页](#信源摘要页模板)
  - [实体/产品页](#实体产品页模板)
  - [个人思考页](#个人思考页模板)
  - [输出文档页](#输出文档页模板)
- [双链策略](#双链策略)

---

## 场景一 AGENTS.md 模板

生成时将方括号内容替换为访谈结果中的实际值：

```markdown
# LLM Wiki Schema

## 角色定义

你是 [用户名/角色] 的个人知识库 Agent，负责维护一个以 [信源类型] 为核心的知识库。
你的核心职责是：
1. 维护 Wiki —— 创建、更新、链接 Markdown 页面
2. 整合知识 —— 将新资料融入现有知识体系
3. 保持一致性 —— 确保跨页面引用准确、无矛盾

## 目录结构

[根据翻译规则生成的实际目录结构]

## 页面格式规范

### 标准页面模板

---
title: 页面标题
category: [concepts|cases|sources|entities|thoughts|products|synthesis|outputs]
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2]
sources: [source-filename]
---

# 页面标题

## 摘要
一句话概括。

## 正文
...

## 相关页面
- [[相关页面1]]

## 引用来源
- [文章](../raw/articles/xxx.md)

## 工作流程

### 1. 摄入外部资料
[根据信源类型定制]

### 2. 摄入个人思考
[根据思考记录方式定制]

### 3. 产出综合分析
[根据产出目标定制]

### 4. 查询
先阅读 wiki/index.md 定位相关页面，综合回答，使用 [[]] 引用。

### 5. 整理
检查矛盾、标记过时、找出孤立页面、发现缺失概念。

## 双向关联约束

知识库的价值在于页面之间的关联，而非页面数量。生成 AGENTS.md 时应包含以下分级约束：

必须双向（缺失会导致知识库碎片化）：
- concepts ↔ cases：概念页必须关联至少一个案例，案例页必须引用至少一个概念
- outputs ↔ concepts：输出文档必须引用依据规则，规则页应能反查哪些文档用到它
- outputs ↔ cases：输出文档应引用支撑案例

建议双向（增强知识网络密度）：
- thoughts ↔ sources：思考页关联触发它的信源
- thoughts ↔ cases：思考页关联相关案例
- sources ↔ entities/products：信源页关联从中提取的实体

单向引用：
- synthesis → sources：综合分析必须引用依据信源
- cases → sources：案例来自外部信源时关联回 source 页面

孤立页面（无任何关联）视为不完整，需在后续摄入中补全。

## 写作风格

- 使用中文撰写所有 Wiki 内容
- 保持简洁，优先使用要点列表
- 使用 [[页面名]] 进行内部链接
- 每个页面必须包含"相关页面"和"引用来源"部分
- 日期格式统一为 YYYY-MM-DD

## 注意事项

- 绝不修改 raw/ 目录下的原始资料
- 所有 Wiki 页面由你维护，用户只负责审阅和提问
- 保持索引和日志的及时更新
```

---

## 场景二 AGENTS.md 模板

```markdown
# LLM Wiki Schema

## 角色定义

你是 [用户角色] 的知识库 Agent。
这个知识库的读者是 [受众角色]，他们查阅知识库是为了 [受众目的]。
你的核心职责是：
1. 将 [用户角色] 的判断依据、决策逻辑和历史经验沉淀为结构化 Wiki 页面
2. 确保规则/标准（concepts/）与实际案例（cases/）之间保持双向关联
3. 产出面向受众的成品文档（outputs/），让受众能自主获取信息

## 目录结构

[根据翻译规则生成，通常包含 concepts/、cases/、outputs/、thoughts/]

## 工作流程

### 1. 沉淀审核记录
当 [用户角色] 完成一次审核时：
1. 记录审核的输入（受众提交了什么）
2. 记录审核的判断和依据（用了哪些规则/标准）
3. 记录审核结论（通过/不通过/需修改）
4. 在 wiki/cases/ 创建案例页
5. 关联到 wiki/concepts/ 中对应的规则页
6. 更新 wiki/index.md 和 wiki/log.md

### 2. 沉淀输出内容
当向受众传递信息时：
1. 记录传递的核心内容
2. 将内容结构化为 wiki/outputs/ 中的文档
3. 关联到相关的 concepts/ 和 cases/

### 3. 更新规则
当规则发生变化时：
1. 更新 wiki/concepts/ 中对应的规则页
2. 检查并更新受影响的 cases/ 页面的关联
3. 在 wiki/log.md 中记录变更

### 4. 查询
先阅读 wiki/index.md 定位相关页面，阅读相关 concepts/ 和 cases/，综合回答。

## 双向关联约束

知识库的价值在于页面之间的关联，而非页面数量。生成 AGENTS.md 时应包含以下分级约束：

必须双向（缺失会导致知识库碎片化）：
- concepts ↔ cases：概念页必须关联至少一个案例，案例页必须引用至少一个概念
- outputs ↔ concepts：输出文档必须引用依据规则，规则页应能反查哪些文档用到它
- outputs ↔ cases：输出文档应引用支撑案例
- 创建新规则页时，主动提示"是否有关联案例"
- 创建新案例页时，主动提示"引用了哪些规则"

建议双向（增强知识网络密度）：
- thoughts ↔ sources：思考页关联触发它的信源
- thoughts ↔ cases：思考页关联相关案例

孤立页面（无任何关联）视为不完整。

## 写作风格

- 使用中文撰写所有 Wiki 内容
- 写作时假设读者是 [受众角色]，需要适当解释专业术语
- 保持简洁，优先使用要点列表
- 使用 [[页面名]] 进行内部链接
- 每个页面必须包含"相关页面"和"引用来源"部分

## 注意事项

- 绝不修改 raw/ 目录下的原始资料
- 参考知识和上下文知识都要进入 wiki，但必须双向关联
- 不要把可搜索到的通用知识大量搬入 wiki，只记录"我们怎么用这个规则"
```

---

## 页面模板

### 概念/规则页模板

```markdown
---
title: 概念/规则名称
category: concepts
type: [理论|方法|术语|规则|标准]
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2]
related_cases: [case-filename-1]
---

# 概念/规则名称

## 定义
这个概念/规则是什么，一句话说清楚。

## 详细说明
### 适用场景
### 核心要素
### 判断标准

## 实际应用案例
- [[案例1]] —— 在这个项目中如何应用了这条规则

## 相关页面
- [[相关概念]]
- [[相关案例]]

## 引用来源
- [来源文件](../raw/xxx.md)
```

### 案例页模板

```markdown
---
title: 案例标题
category: cases
type: [好案例|坏案例|完整项目]
industry: [行业]
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2]
related_concepts: [concept-filename-1]
sources: [source-filename-1]
---

# 案例：标题

## 背景
- 涉及的角色、时间、项目
- 面临的核心问题或决策点

## 过程
### 输入
收到了什么

### 判断依据
- [[规则1]] —— 用在这里判断 XX

### 决策
最终做了什么决定

## 结果
- 量化结果
- 定性影响
- 后果（特别是坏案例）

## 关键洞察
- 为什么这个案例重要
- 可迁移的经验或教训

## 相关页面
- [[用到的规则/概念]]

## 引用来源
- [来源文件](../raw/xxx.md)
```

### 信源摘要页模板

```markdown
---
title: 信源标题
category: sources
source_type: [文章|播客|视频|论文|报告]
source_url: [原始链接]
author: [作者]
published: YYYY-MM-DD
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2]
related_concepts: [concept-filename-1]
related_cases: [case-filename-1]
related_entities: [entity-filename-1]
---

# 信源标题

## 摘要
这篇内容讲了什么，两三句话概括。

## 关键观点
- 观点1
- 观点2

## 提取的知识
- [[概念1]] —— 从这篇内容中提炼的概念
- [[案例1]] —— 这篇内容中的具体案例
- [[实体1]] —— 提到的人/组织/产品

## 个人评注
这篇内容的价值在哪，可信度如何。

## 相关页面
- [[相关概念]]
- [[相关案例]]

## 引用来源
- [原始文件](../raw/articles/xxx.md)
```

### 实体/产品页模板

```markdown
---
title: 实体/产品名称
category: [entities|products]
type: [人物|组织|产品|技术]
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2]
related_sources: [source-filename-1]
related_concepts: [concept-filename-1]
---

# 实体/产品名称

## 简介
一句话说明这是什么/谁。

## 关键信息
- 行业/领域
- 核心业务/产品
- 关键人物（如适用）

## 在知识库中的角色
这个实体在哪些案例和概念中被提及，扮演了什么角色。

## 相关页面
- [[相关概念]]
- [[相关案例]]

## 引用来源
- [来源文件](../raw/xxx.md)
```

### 个人思考页模板

```markdown
---
title: 思考标题
category: thoughts
status: [萌芽|发展中|成熟|已验证]
related_sources: [source-filename-1]
related_cases: [case-filename-1]
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2]
---

# 思考标题

## 触发点
## 核心想法
## 与现有知识的连接
## 待验证的问题
## 可能的行动
## 更新记录

## 相关页面
- [[相关概念]]
- [[相关案例]]

## 引用来源
- [原始思考](../raw/thoughts/xxx.md)
```

### 输出文档页模板

```markdown
---
title: 输出文档标题
category: outputs
target_audience: [受众角色]
purpose: [文档目的]
created: YYYY-MM-DD
updated: YYYY-MM-DD
tags: [tag1, tag2]
related_concepts: [concept-filename-1]
related_cases: [case-filename-1]
---

# 输出文档标题

## 适用范围
## 核心内容
## 参考规则
- [[规则1]]
## 参考案例
- [[案例1]]
## 使用说明

## 相关页面
- [[相关规则]]

## 引用来源
- [来源文件](../raw/xxx.md)
```

---

## 双链策略

### 实现方式

1. 页面内链接：`[[页面名]]` 格式
2. frontmatter 关联：`related_concepts` / `related_cases` / `related_sources`
3. 索引维护：`wiki/index.md` 维护关联关系

### 约束规则

约束分三级，按场景生效：

**必须双向**（缺失会导致知识库碎片化）：

| 关联类型 | 场景一 | 场景二 | 原因 |
|---------|-------|-------|------|
| concepts ↔ cases | 必须 | 必须 | 概念没有案例是空定义，案例没有概念是无法复用的流水账 |
| outputs ↔ concepts | 必须 | 必须 | 输出文档必须引用依据规则，规则应能反查哪些文档用到它 |
| outputs ↔ cases | 必须 | 必须 | 输出文档应引用支撑案例，让受众从"规定"跳转到"实际怎么做" |

**建议双向**（增强知识网络密度）：

| 关联类型 | 场景一 | 场景二 | 原因 |
|---------|-------|-------|------|
| thoughts ↔ sources | 建议 | 建议 | 思考由什么触发，信源因思考而增值 |
| thoughts ↔ cases | 建议 | 建议 | 思考可能改变对案例的判断，案例可能触发新思考 |
| sources ↔ entities/products | 建议 | 不适用 | 从信源提取的实体应关联回原始信源 |

**单向引用**（只需一方指向另一方）：

| 关联类型 | 场景一 | 场景二 | 原因 |
|---------|-------|-------|------|
| synthesis → sources | 必须 | 不适用 | 综合分析必须引用依据信源，以便追溯 |
| cases → sources | 建议 | 不适用 | 案例来自外部信源时应关联回 source 页面 |

### 维护机制

1. 创建新页面时检查可关联的已有页面
2. 更新页面时检查关联页面是否需要同步
3. 定期整理：找孤立页面、断链、不对称链接
