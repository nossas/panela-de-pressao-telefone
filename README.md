Panela de pressão 
==========================

Serviço de pressão por telefone do Panela de Pressão.


# Como funciona?

 - Configure as chaves do twilio no env. `TWILIO_KEY` e `TWILIO_TOKEN`
 - Configure o numero que o serviço vai usar no env, `TWILIO_NUMBER`
 - Configure as URLs que vão lidar com espera de chamada e de fechamento (`HANDLER_URL`, `HANGUP_URL`)
 - Configure um telefone de Fallback (`FALLBACK_PHONE`)
 
 
## REST

1. Uma aplicação chama por `/handle/:numeroalvo/:numeroorigem
2. O twilio faz a ligação do número que voce configurou (`TWILIO NUMBER`) para o `NUMEROORIGEM` (usuário. etc).
3. O `NUMEROORIGEM` atende e em seguida a api faz a conexão com o `NUMEROALVO`.
4. Quando a ligação termina (uma das partes desconecta), o serviço finaliza a chamada.
5. Pronto.



