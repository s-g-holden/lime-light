resource "aws_iam_role" "task_execution_role" {
  name               = "${local.name}_task_execution_role"
  description        = "A general role that grants permissions to start the containers defined in a task."
  assume_role_policy = data.aws_iam_policy_document.ecs_tasks_assume.json
}

resource "aws_iam_role_policy" "task_execution_role" {
  name   = "${local.name}_execution_task_execution_role_policy"
  role   = aws_iam_role.task_execution.id
  policy = data.aws_iam_policy_document.task_etask_execution_rolexecution.json
}

resource "aws_iam_role_policy_attachment" "task_execution_role" {
  role       = aws_iam_role.task_execution_role.name
  policy_arn = aws_iam_policy.task_execution_role[0].arn
}