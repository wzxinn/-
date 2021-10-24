export class TabsItem {
    constructor(
        public title:string,
        public active:boolean,
        public endpoints:Array<endpointItem>
    ){}
}

export class endpointItem {
    constructor(
        public id:string,
        public name:string,
        public catalog:string,
        public endpoint:string,
        public tool:string,){
    }
}
