import { ResponseTemplate } from './response-template';


export const CsudMock:ResponseTemplate = {
    endpoint: [
        {
            id: "123",
            cn_name: "中文名1",
            en_name: "en name 1",
            catagroy: "SC_Meshin",
            endpoint: "http:www.baidu.com",
            tool: "SC_Meshin1",
        },
        {
            id: "1234",
            cn_name: "中文名2",
            en_name: "en name 2",
            catagroy: "SC_Meshin",
            endpoint: "http:www.baidu.com",
            tool: "SC_Meshin2",
        },
        {
            id: "12345",
            cn_name: "中文名3",
            en_name: "en name 3",
            catagroy: "SC_Meshin",
            endpoint: "http:www.baidu.com",
            tool: "SC_Meshin3",
        },
        {
            id: "123456",
            cn_name: "中文名4",
            en_name: "en name 4",
            catagroy: "SC_Meshin",
            endpoint: "http:www.baidu.com",
            tool: "SC_Meshin1",
        }
    ],
    services: [
        {
            type: "SDR",
            urls: "#asdas=1,ss=2,cc=3",
        }
    ],
};