## How to deploy your changes:
You can use sfdx by running the following command:
```
sfdx force:source:deploy -x path/to/package.xml
```

Or you can chose for doing that by clicking with the right button of the mouse on the 
```
package.xml file -> "Deploy Source in Manifest to Org"
```

Obs: Don't forget to authorize your org first :)

## How to execute Emp Connector:
First of all, walk through the EMP-Connector folder by terminal command:
```
cd EMP-Connector
```

Then, you can subscribe to the available channel on your org by running the following command:
```
java -jar target/emp-connector-0.0.1-SNAPSHOT-phat.jar <your-username> <your-password+token> /data/Employee__ChangeEvent
```

Here the channel is the one mentioned in trailhead. Walk together by visiting the [resource](https://trailhead.salesforce.com/content/learn/modules/change-data-capture/subscribe-to-events)