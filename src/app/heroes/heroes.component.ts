import { Component, OnInit } from '@angular/core';
import { of } from 'rxjs';
import { Injectable } from '@angular/core';
import { map } from 'rxjs/operators';
import { tap } from 'rxjs/operators';
import { CsudMock } from './model/mock-csud';
import { TabsItem, endpointItem } from './model/tabsMetaData';

@Component({
  selector: 'app-heroes',
  templateUrl: './heroes.component.html',
  styleUrls: ['./heroes.component.scss']
})


export class HeroesComponent implements OnInit {
  public tabs:Array<TabsItem> = [];
  public Mock = CsudMock;
  public lang = 'zh-cn';
  constructor(  ) { 
    
  }

  ngOnInit(): void {
    this.print();
  }

  print(){
      const observable = of(this.Mock);
      const newObservable = observable.pipe(
          map((item) => {
            //封装tab
            let uri = item.services[0].urls;
            let endpoints: Array<endpointItem> = item.endpoint.map((endpoint)=>{
              let name = (this.lang==='zh-cn') ? endpoint.cn_name : endpoint.en_name;
              let urls = endpoint.endpoint += item.services[0].urls;
              return new endpointItem(endpoint.id,name,endpoint.catagroy,urls,endpoint.tool) })
            return endpoints;
          })
      ).subscribe(data => console.log(this.groupBy(data)));
  }

  groupBy(endpointData:Array<endpointItem>){
    let map:Array<TabsItem> = [];
    let dest:Array<string> = [];
    endpointData.forEach((endpointItem)=>{
      if(!dest.includes(endpointItem.tool)) {
        dest.push(endpointItem.tool);
        this.tabs.push(new TabsItem(endpointItem.tool,false,Array.of(endpointItem)));
      }else{
        map.find((tab)=>tab.title==endpointItem.tool)?.endpoints.push(endpointItem);
      };
    });
  }
}

