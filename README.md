# RP_AWS_DASBO

Basic setup for dasbo developers.


Setup the AWS environment using the main.tf file.

Make sure all the plugins are installed using:

```bash
terraform init
```

Test if there are any errors in the config.

```bash
terraform plan
```

Build the environment:

```bash
terraform apply
```

# Configuring installed AWS nodes

Once the nodes have been installed they should contact the salt-master over ipv6. Use the command below to see if they new nodes have been added.

```bash
sudo salt-key -L
```
In case the keys are already accepted because autosign was configured then the configuration of a node should have already started. In case you did not please use the command below to accept a given key:

```bash
sudo salt-key -a <minion-name>
```

After accepting the key the configuration of the node can be triggered using the higstate or state.apply command.

```bash
sudo salt <minion-name> state.highstate
# or
sudo salt <minion-name> state.apply
```

# Changing salt-master

By default the static AWS salt-master will be used (outside of AWS). In case a salt-master in the AWS environment is needed please take a look at the wiki page for setting that up.
