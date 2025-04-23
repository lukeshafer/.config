Steps to test:

> Note: we're not going to retain the draft buckets anymore since they are temporary and usually sit empty. I'll just warn Ryan about the migration

1. In current v2 branches, change "default removal policy" from "retain" back to "remove" for non-prod stages

2. Deploy in dev + qa

3. Add removal protection to database and buckets (i believe there are 6)
    ```js
    import { RemovalPolicy } from "aws-cdk-lib";

    // dynamo
    new Table(stack, "Table", {
      cdk: {
        table: {
          removalPolicy: RemovalPolicy.DESTROY,
        },
      },
    });

    // buckets
    new Bucket(stack, "Bucket", {
      cdk: {
        bucket: {
          autoDeleteObjects: false,
          removalPolicy: RemovalPolicy.RETAIN // check this
        },
      },
    });
    ```
4. Remove existing 'luke' stage (if exists) and all resources that may have been accidentally retained

5. Run `sst deploy` in local env for `luke` stage. Ensure everything is deployed correctly.
    - Why deploy? Because realistically, we don't need to test this with `sst dev` since production doesn't use it, and our dev environment gets replaced every so often. 

6. Create sample data for the site -- we want to be sure everything transfers. 
    - one season
    - two cards
    - two rarities
    - 4 packs, open 3

7. In AWS console, locate the table and bucket names required and add to the `sst-3-migration` branch for the `luke` stage.
    - Data table
    - Cards bucket (for CDN)
    - Card designs bucket
    - Rarity designs bucket

8. In the v3 branch, run `sst deploy` with the `luke` stage.

This deploy should be successful and ideally won't have errors, but if it does, we need to address them before deploying in other stages.
