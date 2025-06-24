//
// Create a new IAM Service Account IAM Policy.
//
resource "yandex_iam_service_account" "kuber" {
  name        = "kuber"
  description = "service account to manage VMs"
}
//
// Create a new IAM Service Account IAM Member.
//
resource "yandex_iam_service_account_iam_member" "admin-account-iam" {
  service_account_id = yandex_iam_service_account.kuber.id
  role               = "admin"
  member             = "serviceAccount:${yandex_iam_service_account.kuber.id}"

}
