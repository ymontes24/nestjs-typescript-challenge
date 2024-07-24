import { Injectable, Logger } from '@nestjs/common';
import AWS from 'aws-sdk';

@Injectable()
export class CloudWatchService {
  private readonly logger = new Logger(CloudWatchService.name);
  private cloudwatch: AWS.CloudWatch;

  constructor() {
    this.cloudwatch = new AWS.CloudWatch({
      region: 'us-east-2',
      credentials: {
        accessKeyId: process.env.AWS_ACCESS_KEY_ID,
        secretAccessKey: process.env.AWS_SECRET_ACCESS_KEY,
      },
    });
  }

  public async sendMetricData(
    metricName: string,
    value: number,
  ): Promise<void> {
    const params = {
      MetricData: [
        {
          MetricName: metricName,
          Dimensions: [
            {
              Name: 'Application',
              Value: 'nestjs-typescript-challenge ',
            },
          ],
          Unit: 'Count',
          Value: value,
        },
      ],
      Namespace: 'NestJSChallenge',
    };

    try {
      await this.cloudwatch.putMetricData(params).promise();
      this.logger.log(`Metric ${metricName} sent to CloudWatch`);
    } catch (error) {
      this.logger.error(
        `Error sending metric ${metricName} to CloudWatch`,
        error.stack,
      );
    }
  }
}
