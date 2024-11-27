<div align="center">
<img src="https://github.com/user-attachments/assets/208a0ebb-ca7c-4b0b-9f68-0b35050a9880" width="30%" />
</div>

# Lanchonete do Bairro - Infraestrutura AWS (POS TECH: TECH CHALLENGE - 3a FASE)🚀

Este é o repositório responsável pela infraestrutura base e infraestrutura Kubernetes do sistema na nuvem AWS.

Integrantes do grupo:<br>
Alexis Cesar (RM 356558)<br>
Bruna Gonçalves (RM 356557)

## Subindo a infraestrutura com Terraform Manualmente
Passos necessários para subir a infraestrutura base na nuvem da AWS de forma manual.

Requisitos:
- AWS CLI instalada;
- Terraform instalado;
- Credenciais AWS configuradas;
- Subir a infraestrutura com Terraform: ```terraform apply```

## Subindo a infraestrutura Kubernetes no EKS Manualmente
Passos necessários para subir a infraestrutura kubernetes no EKS de forma manual.

Requisitos:
- Infraestrutura AWS rodando;
- Helm instalado;
- Kubectl instalado;
- Powershell instalado;
- Kubectl atualizado para interagir com o eks: ```aws eks update-kubeconfig --region us-east-1 --name eks_lanchonete-do-bairro```
- Executar o script ```runApplicationK8s.ps1```