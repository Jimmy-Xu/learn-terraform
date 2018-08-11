# Generate self-signed certificates
https://coreos.com/os/docs/latest/generate-self-signed-certificates.html

# Enable the remote API with TLS authentication
https://coreos.com/os/docs/latest/customizing-docker.html

> **NOTICE**: The following private key file is only used for demo.


# Usage

## install cfssl

```
//example: get cfssl for macosx
$ brew install cfssl
$ mkdir ~/cfssl
$ cd ~/cfssl
```

## Generate CA

```
//generate default option file
$ cfssl print-defaults config > ca-config.json
$ cfssl print-defaults csr > ca-csr.json

//generate CA certificate and private key
$ cfssl gencert -initca ca-csr.json | cfssljson -bare ca -

the following files will be generated:
ca-key.pem
ca.csr
ca.pem
```

## Generate server certificate

```
//generte default option file
$ cfssl print-defaults csr > server-csr.json

//generate server certificate and private key
$ cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=server server-csr.json | cfssljson -bare server

the following files will be generated:
server-key.pem
server.csr
server.pem
```

## Generate client certificate

```
//generte default option file
$ cfssl print-defaults csr > client-csr.json

////generate cliet certificate and private key
$ cfssl gencert -ca=ca.pem -ca-key=ca-key.pem -config=ca-config.json -profile=client client-csr.json | cfssljson -bare client

the following files will be generated:
client-key.pem
client.csr
client.pem
```