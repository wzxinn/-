export class ResponseTemplate {
    public endpoint!: Array<endpointItem>;
    public services!: Array<serviceItem>;
}

class endpointItem {
    id!: string;
    en_name!: string;
    cn_name!: string;
    catagroy!: string;
    endpoint!: string;
    tool!: string;
}

class serviceItem {
    type!: string;
    urls!: string;
}