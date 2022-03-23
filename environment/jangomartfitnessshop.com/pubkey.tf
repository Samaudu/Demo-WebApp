# Create a key-pair

resource "aws_key_pair" "ssh-key" {
  key_name   = "ssh-key"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQClUuQnPuOKvG6D5Ji6WVnVHc/5h/f3gWTR0pjkGQXO7lVKJPR5j8yDcmc03UHX3iUeW8CeSxBZek2nFJcwe8YVYkzKjhBJN/HGOxcscXIBewJoYXzd3prNnD4O84PxqxgMSwb2JzUiD4q88r7/W21Y6tBbgPs2NJEyDFNpMTJ7k6r7jfTx6LatwjKDf6oMxqGNgwi3xyUh/gw0gk3JtYVb7dBOUmc5NKBfC0drVb025Rl250XoJdG+IfeLQJS/px3pj153V4VHMS0cRfIzUMafvAJVV10mrOF1NUaeLCEXJ6jFHZ3xu7Jqmx+FeeojGVNf33dXD9E25qmM0fZK1N1n ec2-user@ip-172-31-16-182.us-west-2.compute.internal"
}