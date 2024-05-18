function FindProxyForURL(url, host) {
    if (dnsDomainIs(host, "chatgpt.com") || shExpMatch(host, "*.chatgpt.com") || shExpMatch(host, "*.openai.com") || shExpMatch(host, "*.oaistatic.com")) {
        return "PROXY 18.170.153.27:3128";
    }
    
    return "DIRECT";
}
