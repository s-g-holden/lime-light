data "aws_iam_policy_document" "task_execution_role" {
  source_policy_documents = [
    data.aws_iam_policy_document.get_ssm_params.json,
    data.aws_iam_policy_document.write_cw_logs.json,
    data.aws_iam_policy_document.image_pull.json
  ]
}

data "aws_iam_policy_document" "get_ssm_params" {
  statement {
    sid = "SSMGetParamAllow"

    actions = [
      "ssm:GetParameters"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "write_cw_logs" {
  statement {
    sid = "CWWriteLogs"

    actions = [
      "logs:CreateLogGroup",
      "logs:CreateLogStream",
      "logs:PutLogEvents",
      "logs:DescribeLogStreams"
    ]

    resources = ["arn:aws:logs:*"]
  }
}

data "aws_iam_policy_document" "image_pull" {
  statement {
    sid = "ECRImagePull"

    actions = [
      "ecr:BatchCheckLayerAvailability",
      "ecr:BatchGetImage",
      "ecr:GetDownloadUrlForLayer",
      "ecr:GetAuthorizationToken"
    ]

    resources = ["*"]
  }
}

data "aws_iam_policy_document" "ecs_tasks_assume" {
  statement {
    effect = "Allow"
    actions = [
      "sts:AssumeRole"
    ]

    principals {
      type = "Service"
      identifiers = [
        "ecs-tasks.amazonaws.com"
      ]
    }
  }
}