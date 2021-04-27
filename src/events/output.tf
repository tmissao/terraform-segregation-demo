output "event_queue" {
  value = {
    for k, v in aws_sqs_queue.events: k => {
     "id" = v.id
      "arn" = v.arn
    }
  }
}
