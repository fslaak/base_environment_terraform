"""Convert csv to yaml file."""
import ruamel.yaml
import csv
import argparse

csv_file = 'desktops.csv'
check = 'desktops'
yml = ruamel.yaml
primary_key = 'serialnumber'
main_ip_tag = 'IPMain'
prefix = 'drac'

class CsvToYaml():

    def __init__(self):
        self.total_dict = {}
        self.yaml_dict = {}
        self.dns_dict = {}

    def Csv_To_Dict(self, csv_file, primary_key, output):

        with open(csv_file, newline='') as csvfile:
            value_reader = csv.DictReader(csvfile, delimiter=',')
            inter_dict = {}
            for row in value_reader:
                dict_list = {}
                dict = {row[primary_key]: {
                  }
                }
                for key, value in row.items():
                    dict_list.update({key: value})
                dict[row[primary_key]] = dict_list
                inter_dict.update(dict)
            self.total_dict.update(inter_dict)

        self.yaml_dict[output] = self.total_dict
        return self.yaml_dict

    def generate_dns_records(self, domain, ip, primary_key, prefix):
        with open(csv_file, newline='') as csvfile:
            value_reader = csv.DictReader(csvfile, delimiter=',')
            inter_dict = {}
            for row in value_reader:
                ip_addr = row[ip]
                hostname = row[primary_key]
                d_name = row[domain]
                if prefix:
                    combined = '{0}.{1}.{2}.'.format(prefix, hostname, d_name)
                else:
                    combined = '{0}.{1}.'.format(hostname, d_name)
                dict = {combined: ip_addr}
                inter_dict.update(dict)
            self.dns_dict.update(inter_dict)
        return self.dns_dict

        self.yaml_dict[output] = self.total_dict
        return self.yaml_dict

    def dump_dict_to_yaml(self, yaml_dict, file):
        with open(file, 'w') as fp:
            yml.round_trip_dump(yaml_dict, fp, block_seq_indent=2)


class ClientServerOptions():
    """Parse arguments."""

    def __init__(self):
        self.parser = argparse.ArgumentParser(description='''CSV to YAML
                                                             conversion''')

    def arguments(self):
        """Command line options."""
        self.parser.add_argument(
                '--csv',
                dest="CSV",
                action="store",
                default='desktop.csv',
                help="""
                Specify the csv file that will be used.
                """,
                required=True,
            )
        self.parser.add_argument(
                '--output-file-name',
                dest="OUTPUT",
                action="store",
                default="desktop",
                help="""
                Specify yaml output file.
                """,
                required=False,
            )
        self.parser.add_argument(
                '--yaml',
                dest="YAML",
                action="store_true",
                default=False,
                help="""
                Specify to output file as yaml.
                """,
                required=False,
            )
        self.parser.add_argument(
                '--sls',
                dest="SLS",
                action="store_true",
                default=False,
                help="""
                Specify to output file as sls (pillar).
                """,
                required=False,
            )
        self.parser.add_argument(
                '--prim-key',
                dest="PRIMARY",
                action="store",
                default='ServiceTag',
                help="""
                Specify the column that should be used as the primary key
                to setup a nested dictionary.
                """,
                required=True,
            )
        self.parser.add_argument(
                '--generate-dns',
                dest="DNS",
                action="store_true",
                default=False,
                help="""
                Specify a yaml dictionary with A records need to be generated.
                The output file can be used for the pillar file that is used
                for the saltstack bind formula.
                """,
                required=False,
            )
        self.parser.add_argument(
                '--domain-column',
                dest="DOMAIN",
                action="store",
                default="domain",
                help="""
                Specify a yaml dictionary with A records need to be generated.
                The output file can be used for the pillar file that is used
                for the saltstack bind formula.
                """,
                required=False,
            )
        self.parser.add_argument(
                '--ip-column',
                dest="IP",
                action="store",
                default="IPMain",
                help="""
                Specify a yaml dictionary with A records need to be generated.
                The output file can be used for the pillar file that is used
                for the saltstack bind formula.
                """,
                required=False,
            )
        self.parser.add_argument(
                '--subdomain',
                dest="PREFIX",
                action="store",
                default="",
                help="""
                Specify a string that needs to be prepended to the domain name.
                Example value 'adrac', the output is:
                  adrac.example.com
                """,
                required=False,
            )
        args = self.parser.parse_args()
        return args


if __name__ == '__main__':
    parse_options = ClientServerOptions()
    csv_convert = CsvToYaml()
    options = parse_options.arguments()
    csv_file = options.CSV
    yaml_file = options.YAML
    sls_file = options.SLS
    output = options.OUTPUT
    primary_key = options.PRIMARY
    domain_name = options.DOMAIN
    ip_column = options.IP
    prefix = options.PREFIX
    converted_csv = csv_convert.Csv_To_Dict(csv_file, primary_key, output)
    if sls_file:
        csv_convert.dump_dict_to_yaml(converted_csv, '{0}.sls'.format(output))
    if yaml_file:
        csv_convert.dump_dict_to_yaml(converted_csv, '{0}.yml'.format(output))
    if options.DNS:
        d_dict = csv_convert.generate_dns_records(domain_name,
                                                  ip_column,
                                                  primary_key,
                                                  prefix)
        csv_convert.dump_dict_to_yaml(d_dict, '{0}.yml'.format(output))
