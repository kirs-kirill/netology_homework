locals {
    ssh-key = file("~/.ssh/id_ed25519.pub") #ssh-keygen -t ed25519
}