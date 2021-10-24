import { TestBed } from '@angular/core/testing';

import { CsudService } from './csud.service';
import { Injectable } from '@angular/core';
import {Observable} from 'rxjs';
import { Subject } from 'rxjs';

describe('CsudService', () => {
  let service: CsudService;

  beforeEach(() => {
    TestBed.configureTestingModule({});
    service = TestBed.inject(CsudService);
  });

  it('should be created', () => {
    expect(service).toBeTruthy();
  });
});

@Injectable()
export class MessageService {
    private subject = new Subject<any>();

    sendMessage(message: string) {
        this.subject.next({ text: message });
    }

    clearMessage() {
        this.subject.next();
    }

    getMessage(): Observable<any> {
        return this.subject.asObservable();
    }
}
