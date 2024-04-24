from integration.mysql_connector import MySQLConnector


class DmtDBOperation:
    connector: MySQLConnector

    def __init__(self):
        self.connector = MySQLConnector()

    def get_profiles(self):
        return self.connector.execute("select * from dmt.profile;")

    def get_profile_device(self):
        return self.connector.execute("select * from dmt.profile_device;")

    def get_profile_account(self, user_name: str, password: str):
        return self.connector.execute(f"select user.account_id, p.profile_id, p.name profile_name, p.role profile_role from dmt.user user, dmt.profile p where user.name={user_name} and user.password={password} and user.profile_id = p.profile_id;")

    def get_profile_matter_devices_on_pid_and_nid(self, profile_id: int, nid_id: int):
        return self.connector.execute(f"select pd.device_id, d.name device_name, pd.node_id, m.name node_name, pd.access, d.status, d.location from dmt.profile_device pd, dmt.matter m, dmt.device d where pd.node_id = {nid_id} and pd.node_id = m.node_id and pd.device_id = d.device_id and pd.profile_id = {profile_id};")

    def get_profile_matter_devices_on_pid(self, profile_id: int):
        return self.connector.execute(f"select pd.device_id, d.name device_name, pd.node_id, m.name node_name, pd.access, d.status, d.location from dmt.profile_device pd, dmt.matter m, dmt.device d where pd.node_id = m.node_id and pd.device_id = d.device_id and pd.profile_id = {profile_id};")

    def get_profile_matter_devices_on_account_nid_did(self, profile_id: int, node_id: int, device_id: int):
        return self.connector.execute(f"select pd.device_id, pd.node_id, pd.access, d.status, d.location, p.profile_id, p.name profile_name, p.role profile_role from dmt.user u, dmt.profile p, dmt.profile_device pd, dmt.matter m, dmt.device d where u.account_id = (select account_id from dmt.user where profile_id = {profile_id}) and u.profile_id = p.profile_id and u.profile_id = pd.profile_id and pd.node_id = {node_id} and pd.node_id = m.node_id and pd.device_id = {device_id} and pd.device_id = d.device_id;")

    def get_profile_matter_devices_on_pid_nid_did(self, profile_id: int, node_id: int, device_id: int):
        return self.connector.execute(f"select pd.device_id, pd.node_id, pd.access, d.status, d.location, p.profile_id, p.name profile_name, p.role profile_role from dmt.profile p, dmt.profile_device pd, dmt.matter m, dmt.device d where pd.profile_id = {profile_id} and pd.node_id = {node_id} and pd.node_id = m.node_id and pd.device_id = {device_id} and pd.device_id = d.device_id;")

    def update_device_status(self, did_list: [int], status: str):
        return self.connector.execute(f"update dmt.device set status = '{status}' where device_id in ({','.join([str(did) for did in did_list])})")

    def update_device_location(self, device_id: int, location: str):
        return self.connector.execute(f"update dmt.device set location = '{location}' where device_id = {device_id}")

    def update_profile_device_access(self, profile_id: int, node_id: int, device_id: int, access: bool):
        return self.connector.execute(f"update dmt.profile_device set access = {access} where profile_id = {profile_id} and node_id = {node_id} and device_id in ({device_id})")

    def discover_new_matter_devices(self):
        return self.connector.call_procedure('discover_and_pair_new_matter_devices')

    def delete_matter_devices_on_matter_node_id(self, node_id: int):
        return self.connector.execute(f"DELETE m, md, d, pd FROM dmt.matter AS m LEFT JOIN dmt.matter_device AS md ON m.node_id = md.node_id LEFT JOIN dmt.device AS d ON md.device_id = d.device_id LEFT JOIN dmt.profile_device AS pd ON pd.device_id = d.device_id WHERE m.node_id={node_id};")

