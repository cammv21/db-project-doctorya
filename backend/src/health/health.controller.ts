import { Controller, Get} from '@nestjs/common';
import { ApiTags } from '@nestjs/swagger';


@ApiTags('Health') // Tag for this controller
@Controller('health')
export class HealthController {
  constructor() {}

  @Get('check')  
  check() {
    return {
      status: 'OK',
      timestamp: new Date().toISOString(),
    };
  }
  
}
