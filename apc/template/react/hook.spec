import { renderHook } from '@testing-library/react';
import { ${name_capital} } from './${name}';

describe('${name_capital}', () => {
  it('should render successfully', () => {
    const { result } = renderHook(() => ${name_capital}());
    expect(result.current).toBeTruthy();
  });
});
