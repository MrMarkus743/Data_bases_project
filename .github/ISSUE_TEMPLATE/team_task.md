---
name: '👥 Team Task'
about: 'Collaborative task with role delegation, shared branch and delivery plan'
title: '[Module] Task title'
labels: ''
assignees: ''
---

### 🎯 Objective
<!-- Краткое техническое описание цели задачи: предмет реализации и ожидаемый артефакт -->


### 👥 Roles & Responsibilities
<!-- Распределение обязанностей в порядке ролевой иерархии и привилегий -->
*  **Task Lead**:
  * 
* 🔵 **Developer**:
  * 
* 🟢 **Database Administrator**:
  * 
* 🟣 **Data Analyst**:
  * 


### Branching Strategy & Workflow
Target Branch: `develop`
Feature Branch: `<type>/<task-name>` (e.g. `feat/data-flow-diagram` or `sql/audit-log-triggers`)

- **Workflow protocol:**
  1. Выполнить ветвление от актуального `develop` (`git checkout -b <branch>`).
  2. Реализовать изменения и зафиксировать атомарные коммиты по Conventional Commits.
  3. Локальное тестирование и проверка перед формированием Pull Request.

### 📋 Execution Plan
- [ ] **1. Title:**
  - [ ] 
  - [ ] 
- [ ] **2. Title:**
  - [ ] 
- [ ] **3. Pull Request:**
  - [ ] Формирование PR в ветку `develop` с обязательным указанием `Closes #<issue_number>`
