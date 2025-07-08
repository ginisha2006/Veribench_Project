import re

def convert_fv_sv_to_verilog(filename_in, filename_out):
    with open(filename_in, 'r') as f:
        code = f.read()

    # Step 1: Extract properties and convert them
    property_defs = re.findall(r'property\s+(\w+);\s*(.*?);?\s*endproperty', code, re.DOTALL)

    prop_exprs = {}
    for name, expr in property_defs:
        cleaned_expr = expr.strip().rstrip(';')
        prop_exprs[name] = cleaned_expr

    # Step 2: Replace `assert property(p_name);` with `assert (expr);`
    for name, expr in prop_exprs.items():
        code = re.sub(rf'assert\s+property\s*\(\s*{name}\s*\)\s*;',
                      f'assert ({expr});',
                      code)

    # Step 3: Remove original property definitions
    code = re.sub(r'property\s+\w+;\s*.*?endproperty\s*', '', code, flags=re.DOTALL)

    # Step 4: Wrap all assert(...) in always @(*) blocks
    def wrap_asserts(match):
        statement = match.group(0)
        return f"always @(*) begin {statement} end"

    code = re.sub(r'assert\s*\(.*?\);', wrap_asserts, code)

    with open(filename_out, 'w') as f:
        f.write(code)

    print(f"✅ Converted: {filename_in} → {filename_out}")

# Example usage
if __name__ == "__main__":
    convert_fv_sv_to_verilog("adder_fv.v", "adder_fv_converted.v")
