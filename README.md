# 🎓 Graph Streaming with Astra and Quine

Welcome to the real-time graph ETL for modern data pipelines with **Quine and Apache Cassandra** workshop! In this two-hour workshop, we show how to combine a scalable database, `Apache Cassandra™`, with a powerful real-time streaming graph processor, `Quine`.

⏲️ **Duration :** 2 hours

🎓 **Level :** Intermediate

![](data/img/splash.png)

Using **Astra DB**, the cloud-based _Cassandra-as-a-Service_ platform delivered by DataStax, we will cover the very first steps for every developer who wants to try to learn a new database: creating tables and CRUD operations.

Quine, from the team at thatDot, is a real-time streaming graph interpreter. A server-side program that consumes data, builds a graph structure, and runs live computation on that graph to answer questions or compute results, and then stream them out.

It doesn't matter if you join our workshop live or you prefer to do it at your own pace, we have you covered. In this repository, you'll find everything you need for this workshop:

> [🔖 Accessing HANDS-ON](#-start-hands-on)

## 📋 Table of contents

1. [Objectives](#objectives)
2. [Frequently asked questions](#frequently-asked-questions)
3. [Materials for the Session](#materials-for-the-session)
4. [Create your Database](#create-your-astra-db-instance)
5. [Setup Quine](#setup-quine)
6. [Graph Exploration](#graph-exploration)
7. [Homework](#homework)
8. [What's NEXT](#whats-next-)

## Objectives

1️⃣ **Give you an understanding of Quine streaming graph**

2️⃣ **Show how to configure Quine to use Cassandra or Astra DB**

3️⃣ **Provide an overview of Quine's Architecture**

4️⃣ **Have you run a streaming scenario to detect an anomaly in the graph**

🚀 **Have fun with an interactive session!**

## Frequently asked questions

<p/>
<details>
<summary><b> 1️⃣ Can I run this workshop on my computer?</b></summary>
<hr>
<p>There is nothing preventing you from running the workshop on your own machine. If you do so, you will need the following installed on your local system:
<ol>
<li><b>git</b>
<li><b>Java 11</b>
</ol>
</p>
In this readme, we try to provide instructions for local development as well - but keep in mind that the main focus is development on Gitpod, hence <strong>we can't guarantee live support</strong> about local development in order to keep on track with the schedule. However, we will do our best to give you the info you need to succeed.
</details>
<p/>
<details>
<summary><b> 2️⃣ What other prerequisites are required?</b></summary>
<hr>
<ul>
<li>You will need enough *real estate* on screen, we will ask you to open a few windows and it would not fit on mobiles (tablets should be OK)
<li>You will need an Astra account: don't worry, we'll work through that in the following
<li>As "Intermediate level" we expect you to know what Java is.  If you don't know what a streaming graph is, or haven't used a graph system before, that's ok...we'll cover that.
</ul>
</p>
</details>
<p/>
<details>
<summary><b> 3️⃣ Do I need to pay for anything for this workshop?</b></summary>
<hr>
<b>No.</b> All tools and services we provide here are FREE. FREE not only during the session but also after.
</details>
<p/>
<details>
<summary><b> 4️⃣ Will I get a certificate or badge if I attend this workshop?</b></summary>
<hr>
Attending the session is not enough. You need to complete the homework detailed below and you will get a nice badge that you can share on LinkedIn or anywhere else *(open badge specification)*
</details>
<p/>

## Materials for the Session

It doesn't matter if you join our workshop live or you prefer to work at your own pace,
we have you covered. In this repository, you'll find everything you need for this workshop:

- [Slide deck](./slides.pdf)
- [Discord chat](https://dtsx.io/discord)
- [Questions and Answers](https://stackoverflow.com/questions/tagged/cassandra/)
- [Twitch backup](https://www.twitch.tv/datastaxdevs)

----

# 🏁 Start Hands-on

## Create your Astra DB instance

_**`ASTRA DB`** is the simplest way to run Cassandra with zero operations at all - just push the button and get your cluster. No credit card required, 40M read/write operations and about 80GB storage monthly for free - sufficient to run small production workloads. If you end your credits the databases will pause, no charge_

Leveraging the [database creation guide](https://awesome-astra.github.io/docs/pages/astra/create-instance/#c-procedure), create a database. *Right-Click the button* with *Open in a new TAB.*

<a href="https://astra.dev/2-16"><img src="data/img/create_astra_db.png?raw=true" /></a>

|Field|Value|
|---|---|
|**Database Name**| `workshops`|
|**Keyspace Name**| `quine`|
|**Regions**| Select `GOOGLE CLOUD`, then Moncks Corner (us-east1) OR an Area close to you, then a region with no LOCK 🔒 icons, those are the region you can use for free.   |

> **ℹ️ Note:** If you already have a database `workshops`, simply add a keyspace `quine` using the `Add Keyspace` button on the bottom right hand corner of db dashboard page.

While the database is being created, you will also get a **Security token**:
save it somewhere safe, as it will be needed later in other workshops (In particular the string starting with `AstraCS:...`.)

The status will change from `Pending` to `Active` when the database is ready, this will only take 2-3 minutes. You will also receive an email when it is ready.

#### Token

> **⚠️ Important**
> ```
> The instructor will show you on screen how to create a token
> but will have to destroy to token immediately for security reasons.
> ```

[🏠 Back to Table of Contents](#-table-of-content)

## Setup Quine

These instructions were written using Java 11.10.  To run Quine locally, follow the steps below.  Or, you can run it in GitPod:

[![Open in Gitpod](https://gitpod.io/button/open-in-gitpod.svg)](https://gitpod.io/#https://github.com/datastaxdevs/workshop-streaming-graph-quine)

### Setup Astra Shell in GitPod

The Astra Shell tool will be included in the GitPod build.  Once the environment has completed its initial build, you should see the following at the bottom of the terminal:

```bash
Open A NEW TERMINAL and run: astra setup
```

Open a new terminal by clicking the plus ( + ) icon on the upper-right corner of the current terminal window.  Then run:

```bash
astra setup
```

You will be prompted to enter (paste) your token.

```bash
• Enter your token (starting with AstraCS) :
```

Once you it <kbd>enter</kbd>, you should see output similar to below:

```
[rags@acm.org]
> ASTRA_DB_APPLICATION_TOKEN=AstraCS:AAAAAAAA
>
> [What's NEXT ?]
> You are all set.(configuration is stored in ~/.astrarc) You can now:
>    • Use any command, 'astra help' will get you the list
>    • Try with 'astra db list'
>    • Enter interactive mode using 'astra'
>
> Happy Coding!
```

Verify the setup with the following command which should list all the databases:

```
astra db list
```

Open a new terminal window and run Quine by executing:
```bash
./start.sh
```

### Download Quine - Local

Follow the [Download Quine page](https://quine.io/download) to download the JAR. Choose/create a directory for Quine, and copy the JAR to another location:

```bash
mkdir -p ~/local/quine
cp quine-1.3.2.jar ~/local/quine/
```

### Configure Quine - Local

Create a `quine.conf` file inside the quine directory:

```bash
cd ~/local/quine
touch quine.conf
```

Edit the `quine.conf` file:

```
quine.store {
  # store data in an Apache Cassandra instance
  type = cassandra
  # the keyspace to use
  keyspace = quine
  should-create-keyspace = false
  should-create-tables = true
  replication-factor = 3
  write-consistency = LOCAL_QUORUM
  read-consistency = LOCAL_QUORUM
  local-datacenter = ${ASTRA_DB_REGION}
  write-timeout = "10s"
  read-timeout = "10s"
}
datastax-java-driver {
  advanced {
    auth-provider {
      class = PlainTextAuthProvider
      username = "token"
      password = ${ASTRA_DB_APP_TOKEN}"
    }
  }
  basic {
    cloud {
      secure-connect-bundle = "/workspace/workshop-streaming-graph-quine/secure-connect-workshops.zip"
    }
  }
}
```

#### Astra-Specific Settings:

`type = cassandra` - If the type is not specified, Quine defaults to use RocksDB.

`should-create-keyspace = false` - Remember keyspaces can only be created in Astra via the dashboard.

`replication-factor = 3` - Defaults to 1 if not set, which will not work with Astra DB.

`write-consistency = LOCAL_QUORUM` - Minimum consistency level required by Astra.

`read-consistency = LOCAL_QUORUM` - Minimum consistency level required by Astra.

`local-datacenter = "us-east1"` - Set your Astra DB cloud region as the local DC.

`username = "token"` - No need to mess with this. Just leave it as the literal word "token."

`password` - A valid token for an Astra DB cluster.

`secure-connect-bundle` - A valid, local file location of a downloaded Astra secure connect bundle. The driver gets the Astra DB hostname from the secure bundle, so there is no need to specify endpoints separately.

### Download the recipe and sample data - Local

Download the "Password Spraying" [recipe](https://raw.githubusercontent.com/datastaxdevs/workshop-streaming-graph-quine/main/password-spraying-workshop.yml) from Github. Move the resulting YAML file to your `quine` directory.

```bash
mkdir ~/local/quine
cp password-spraying-workshop.yml ~/local/quine/
```

Then, download the [sample data file](https://that.re/attempts)" and move the JSON file to your `quine` directory.

```bash
mkdir ~/local/quine
cp attempts.json ~/local/quine/
```

Alternatively, if you have cloned this repository and are working in the repo directory locally, you can run the `get_quine.sh` script. If successful, the script will download the latest version of Quine and the sample data for this workshop, and the script will output something similar to what you see below.

```shell
❯ ./get_quine.sh

HTTP request sent, awaiting response... 200 OK
Length: 220704180 (210M) [application/octet-stream]
Saving to: ‘quine-1.3.2.jar’

quine-1.3.2.jar        100%[=========================================================>] 210.48M  20.5MB/s    in 22s     

2022-10-06 11:13:39 (9.78 MB/s) - ‘quine-1.3.2.jar’ saved [220704180/220704180]

HTTP request sent, awaiting response... 200 OK
Length: 82243423 (78M) [application/json]
Saving to: ‘attempts.json’

attempts.json          100%[=========================================================>]  78.43M  15.4MB/s    in 5.0s    

2022-10-06 11:13:49 (15.8 MB/s) - ‘attempts.json’ saved [82243423/82243423]
```
### Starting Quine - Local

To run Quine using the Password Spray recipe, invoke the JAR with Java, while passing the `quine.conf` as a `config.file` JVM parameter, while also specifying the recipe, like this:

```bash
cd ~/local/quine
java -Dconfig.file=quine.conf -jar quine-1.3.2.jar -r password-spraying-workshop.yml --force-config
```

### Troubleshooting

If Quine starts correctly, it should produce output similar to below:
```bash
2022-06-15 15:11:52,666 WARN [NotFromActor] [s0-io-4] com.datastax.oss.driver.internal.core.cql.CqlRequestHandler - Query '[0 values] CREATE TABLE IF NOT EXISTS journals (quine_id blob,timestamp bigint,data blob,PRIMARY KEY(quine_id,timestamp)) WITH CLUSTERING ORDER BY (timestamp ASC) AND compaction={'class':'TimeWindowCompactionStrategy'}' generated server side warning(s): Ignoring provided values [compaction] as they are not supported for Table Properties (ignored values are: [additional_write_policy, bloom_filter_fp_chance, caching, cdc, compaction, compression, crc_check_chance, dclocal_read_repair_chance, extensions, gc_grace_seconds, id, max_index_interval, memtable_flush_period_in_ms, min_index_interval, nodesync, read_repair, read_repair_chance, speculative_retry])
Graph is ready!
Application state loaded.
Quine app web server available at http://0.0.0.0:8080
```

Quine should then start ingesting the data stream automatically, displaying its progress as it moves along.

If the output does not read:

```
Graph is ready!
Application state loaded.
Quine app web server available at http://locahost:8080
```

Then look for exceptions.

#### Incorrect database name

If you see this error:

```bash
Downloading Astra secure connect bundle...
Picked up JAVA_TOOL_OPTIONS:  -Xmx3489m
[WARN ] - Database workshops has not been found
[WARN ] - Database 'workshops' has not been found.
[ERROR] - NOT_FOUND: Database 'workshops' has not been found.
Download of SCB failed!
```

...this means that your token is not associated with a database named 'workshops'.  Edit the `.env` file with the following GitPod command:

```bash
gp open .env
```

Enter the correct name for your database, and rerun `start.sh`.

#### Snapshots table fails to CREATE

If you see an error:

```
com.datastax.oss.driver.api.core.servererrors.InvalidQueryException: Clustering key columns must exactly match columns in CLUSTERING ORDER BY directive
```

...this means that one of tables (likely the `snapshots` table) failed to CREATE properly.  From GitPod, you can fix this by using the Astra Shell.  If your DB name is different from "workshops," replace it as appropriate.

```bash
astra db cqlsh workshops
```

Check to ensure the `snapshots` table exists:

```
cqlsh> use quine;
cqlsh> desc quine;
```

If not, execute this CQL in Astra Shell (or cqlsh if you're running locally) to create it:

```
CREATE TABLE quine.snapshots (
    quine_id blob,
    timestamp bigint,
    multipart_index int,
    data blob,
    multipart_count int,
    PRIMARY KEY (quine_id, timestamp, multipart_index)
) WITH CLUSTERING ORDER BY (timestamp DESC, multipart_index ASC)
    AND additional_write_policy = '99PERCENTILE'
    AND bloom_filter_fp_chance = 0.01
    AND caching = {'keys': 'ALL', 'rows_per_partition': 'NONE'}
    AND comment = ''
    AND compaction = {'class': 'org.apache.cassandra.db.compaction.UnifiedCompactionStrategy'}
    AND compression = {'chunk_length_in_kb': '64', 'class': 'org.apache.cassandra.io.compress.LZ4Compressor'}
    AND crc_check_chance = 1.0
    AND default_time_to_live = 0
    AND gc_grace_seconds = 864000
    AND max_index_interval = 2048
    AND memtable_flush_period_in_ms = 0
    AND min_index_interval = 128
    AND read_repair = 'BLOCKING'
    AND speculative_retry = '99PERCENTILE';
```

#### Clearing Quine Data

If Quine starts, but you see a message which looks like this:

```bash
Standing Query STANDING-1 already exists
Standing Query STANDING-2 already exists
Ingest Stream INGEST-1 already exists
```

...that means that you'll need to clear the existing data before proceeding.  You can do this by running the `truncate_tables.sh` script from within GitPod.

#### Extra Double Quote on STANDING-2 Link

Once you seen the message indicating that an anomaly has been found, you should be able to <kbd>Ctrl</kbd>+click or <kbd>Command</kbd> click to open the Quine Graph Explorer with a query for that pattern match.  However, sometimes the new tab will open and the page load will fail due to an extra double-quote on the end of the query.  Simply click on the query text well, and press <kbd>End</kbd> to go to the end of the line.  If you see a double quote there, <kbd>backspace</kbd> over it.

### Quine Graph Explorer

You can now use Quine's visual graph explorer in a web browser, and create/traverse data with either Gremlin or Cypher: http://localhost:8080/

[🏠 Back to Table of Contents](#table-of-contents)

## Graph Exploration

The `attempts.json` contains the pattern for one password spraying attack. Quine will produce an alert in the console when the standing query matches the pattern. The alert will look similar to this:

```shell
2022-10-07 09:37:46,255 Standing query `alert` match: {"meta":{"isPositiveMatch":true,"resultId":"7242b979-03c2-2bc3-9879-13661e8359b5"},"data":{"QuineUILink":"Password Spraying Attack: http://localhost:8080/#MATCH%20(user)-[:ORIGINATED]-%3E(attempt1%20%7BoutcomeResult:%22FAILURE%22%7D)-[:NEXT]-%3E(attempt2%20%7BoutcomeResult:%22FAILURE%22%7D)-[:NEXT]-%3E(attempt3%20%7BoutcomeResult:%22FAILURE%22%7D)-[:NEXT]-%3E(attempt4%20%7BoutcomeResult:%22FAILURE%22%7D)-[:NEXT]-%3E(attempt5%20%7BoutcomeResult:%22SUCCESS%22%7D)%20WHERE%20id(attempt1)=%22cb73fb14-4686-3913-8cd8-7d4d608b53d5%22%20RETURN%20DISTINCT%20user%2Cattempt1%2Cattempt2%2Cattempt3%2Cattempt4%2Cattempt5"}}
```

When the alert arrives, hold down the command key on a MAC and right-click the link to open Quine.

You should be able to arrange the graph in your browser into a shape similar to this:

![quine exploration ui](data/img/quine-exploration-ui.png)

Explore the graph using the [Exploration UI](https://docs.quine.io/getting-started/exploration-ui.html) to follow the path of the attack in the event stream.

## Stopping Quine

To stop Quine, you can simply hit <kbd>Ctrl</kbd>+<kbd>c</kbd>.  Or, you can run the `stop.sh` file from a terminal (locally or from within GitPod).

## Homework

To submit the **homework**,

* Write a new recipe or extend an existing one and take SCREENSHOT(s).
  * Visit the Quine [documentation](https://docs.quine.io/docs.html) site
  * Go through the Getting Started -> [Quine Recipes](https://docs.quine.io/getting-started/recipes-tutorial.html) tutorial
  * Create a new recipe from scratch, or...
  * Modify an [existing recipe](https://quine.io/recipes) to do something new
  * Email the SCREENSHOT(s) of Quine running your recipe in the browser and the recipe YAML file

EMAIL:
```text
To: aaron.ploetz@datastax.com, michael@thatdot.com
Subject: Quine Homework
```

## What's NEXT ?

We've just scratched the surface of what you can do using Astra DB, built on Apache Cassandra.
Go take a look at [DataStax for Developers](https://www.datastax.com/dev) to see what else is possible.
There's plenty to dig into!

Congratulations: you made to the end of today's workshop.

**... and see you at our next workshop!**

> Sincerely yours, The DataStax Developers
