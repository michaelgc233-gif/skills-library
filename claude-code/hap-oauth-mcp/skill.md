---
name: hap-oauth-mcp
description: HAP 个人授权 MCP 配置生成技能。当用户需要生成 HAP 个人 MCP 配置、配置用户身份授权的 MCP、获取 HAP OAuth token 时使用。用户只需提供账号和密码，自动完成登录、OAuth 授权和 token 获取，返回可直接使用的 MCP JSON 配置。
---

# HAP Personal MCP Configuration Guide

This document describes a system for generating personalized MCP JSON credentials through HAP OAuth authorization.

## Key Requirements

Users must provide:
- **Account**: Email or phone (mainland China numbers should use "+8613…" format)
- **Password**: Preferably via environment variables rather than in conversation
- **Environment**: Defaults to HAP SaaS with official integration credentials

## Main Process

Repository is installed at `/tmp/hap-oauth-mcp`. Generate MCP config via:

```bash
/tmp/hap-oauth-mcp/.venv/bin/md-generate-mcp-config \
  --account "<account>" --password "<password>" \
  --skip-wait
```

As the documentation states: "stdout出现 **MCP JSON** → 按下文「交付与回复技巧」交给用户" (when MCP JSON appears in stdout, deliver it to the user following delivery guidelines).

## Delivery Best Practices

1. Provide the JSON output directly in a code block for easy copying
2. Keep explanations brief (1-2 sentences only)
3. **Avoid including**: app IDs, specific token fragments, or detailed parameter explanations in responses
4. Use generic references like "official personal MCP integration" instead of specific identifiers
5. Mention that tokens expire and users should request renewal when needed

The guide emphasizes minimizing background explanation and focusing on clean, straightforward delivery of the configuration to end users.
