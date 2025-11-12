# 2025-11-12T13:52:36.124221
import vitis

client = vitis.create_client()
client.set_workspace(path="Matrix_Lab4")

comp = client.create_hls_component(name = "Main",cfg_file = ["hls_config.cfg"],template = "empty_hls_component")

comp = client.get_component(name="Main")
comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp.run(operation="C_SIMULATION")

comp = client.clone_component(name="Main",new_name="reshape")

comp = client.get_component(name="reshape")
comp.run(operation="C_SIMULATION")

comp = client.clone_component(name="Main",new_name="Pipeline")

comp = client.get_component(name="Pipeline")
comp.run(operation="C_SIMULATION")

comp = client.get_component(name="Main")
comp.run(operation="SYNTHESIS")

comp = client.clone_component(name="Main",new_name="Bitwidth")

comp = client.get_component(name="Bitwidth")
comp.run(operation="C_SIMULATION")

comp = client.clone_component(name="Main",new_name="Flatten")

comp = client.get_component(name="Flatten")
comp.run(operation="C_SIMULATION")

comp.run(operation="SYNTHESIS")

comp = client.get_component(name="Pipeline")
comp.run(operation="SYNTHESIS")

comp = client.get_component(name="reshape")
comp.run(operation="SYNTHESIS")

comp = client.get_component(name="Bitwidth")
comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

comp = client.get_component(name="Flatten")
comp.run(operation="CO_SIMULATION")

comp = client.get_component(name="Main")
comp.run(operation="CO_SIMULATION")

comp = client.get_component(name="Pipeline")
comp.run(operation="CO_SIMULATION")

comp = client.get_component(name="reshape")
comp.run(operation="CO_SIMULATION")

comp = client.get_component(name="Main")
comp.run(operation="CO_SIMULATION")

comp.run(operation="SYNTHESIS")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

comp = client.clone_component(name="Flatten",new_name="Dataflow")

comp = client.get_component(name="Dataflow")
comp.run(operation="SYNTHESIS")

comp.run(operation="SYNTHESIS")

comp.run(operation="CO_SIMULATION")

vitis.dispose()

